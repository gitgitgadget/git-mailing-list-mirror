From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Mon, 7 Jul 2008 23:28:15 -0400
Message-ID: <76718490807072028o7e0661a8r6d118cc91dc5e625@mail.gmail.com>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
	 <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
	 <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com>
	 <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org>
	 <7vod591hlp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Brian Gernhardt" <benji@silverinsanity.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 05:29:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG3tC-0003bK-8n
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 05:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbYGHD2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 23:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756055AbYGHD2Q
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 23:28:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:37526 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043AbYGHD2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 23:28:16 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2966047rvb.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 20:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=p3c4PtbL7QZTemaAkZ/O7s9ShJEAFuMvDK4OxPqimsQ=;
        b=ql4T8IUekiCio+8oCu3BHxMndWMmP64I1KDU6nnMkLKLe4uPv8AA9vUHHcTL2G1eSU
         7wnSZrPjRbh52uIScfsgC7C3aHyx/jYbT+Tu7CO1HbK+n+ugcctFteZzqGh1poZqIS7P
         qJ8a1jKNG+6SVxAFl6STF0JMDj2CtVl7hiGlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QQJw1LlaU9f09WMXySexrwh3i1+cFwmMd5QJXXRTVl6Jk8OYjlaqIdyO/ba2Ks7MBM
         a8maKnd9EuIiABfRh0Lm0ncuDnySx4e5CVjGA38tAW4+HS8K333cPO429Ik7cAe5hP5B
         Z4Hmi+vQYRf20zzlAtJ74dBEaulf1xIcEcHoY=
Received: by 10.115.59.2 with SMTP id m2mr7225852wak.197.1215487695337;
        Mon, 07 Jul 2008 20:28:15 -0700 (PDT)
Received: by 10.114.14.19 with HTTP; Mon, 7 Jul 2008 20:28:15 -0700 (PDT)
In-Reply-To: <7vod591hlp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87695>

On Mon, Jul 7, 2008 at 5:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> +HEAD names the commit your changes in the working tree is based on.

How about:

"HEAD names the commit your working tree is based on. This is the tip
of the checked out branch, unless HEAD is detached. (HEAD is said to
be detached if a commit is checked out which is not the tip of any
branch.)"

> +FETCH_HEAD records the branch you fetched from a remote repository
> +with your last 'git-fetch' invocation.

consistency w/above: s/records/names/

> +ORIG_HEAD is created by commands that moves your HEAD in a drastic
> +way, to record the position of the HEAD before their operation, so that
> +you can change the tip of the branch back to the state before you ran
> +them easily.

s/moves/move/; s/can change/can easily change/; s/them easily./them./;

But maybe this reads better:

ORIG_HEAD is created by commands that move HEAD in a drastic way to
record the position of HEAD before their operation, so that the branch
can easily be reset back to its prior state.

> +MERGE_HEAD records the commit(s) you are merging into your branch
> +when you run 'git-merge'.

So it's the "<remote>" arg or args mentioned in the git-merge man page?

j.
