From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v6] add --summary option to git-push and git-fetch
Date: Sun, 31 Jan 2010 20:04:46 +0800
Message-ID: <be6fef0d1001310404n204ffa31g3cf0a6f170507b3e@mail.gmail.com>
References: <20100130011056.GA20463@cthulhu> <20100130020548.GA29343@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 13:05:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbYYN-0006zm-VY
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 13:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab0AaMEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 07:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711Ab0AaMEt
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 07:04:49 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:34599 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0AaMEs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 07:04:48 -0500
Received: by iwn3 with SMTP id 3so3419993iwn.23
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GmiXyMcb0/iFiVGVYi2+7/pa54npBiLxdSlgmDF3YeQ=;
        b=gOmqGy44CO7Yz5UeKFk9AN6QCgQyg3zyonpvpjxt5Ccztnv8B1MXo1NXb86yJEYUyE
         0h7/4KYKBPxgAL3YA2x0hHDtlG1JnJEajQa86ZNDmBj0uxhFh2KT+JLKLtkCE6sfyu0C
         AfOs9w6f2k3hnS7RTLAnygIkQ/zksMbK3ETac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UVNsxms03u1XCVj0IG31eoq/H0RQJm5WunD9EphcUPzDX2IOCYtz5igMUpTLvoKR4M
         OBz/0+w9Te75LA5i9gq7QiIDTXF8wYcd6jJecl6NBHO374OmJHE9eqlISjSAHH2mfGDC
         klI01TvPPV3uQ+K8p097z+fLAwY5EC07hlRkw=
Received: by 10.231.168.132 with SMTP id u4mr469465iby.79.1264939486933; Sun, 
	31 Jan 2010 04:04:46 -0800 (PST)
In-Reply-To: <20100130020548.GA29343@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138540>

Hi,

On Sat, Jan 30, 2010 at 10:05 AM, Larry D'Anna <larry@elder-gods.org> w=
rote:
> --summary will cause git-push to output a one-line of each commit pus=
hed.
> --summary=3Dn will display at most n commits for each ref pushed.
>
> $ git push --dry-run --summary origin :
> To /home/larry/gitsandbox/a
> =A0 80f0e50..5593a38 =A0master -> master
> =A0 =A0> 5593a38 foo
> =A0 =A0> 81c03f8 bar
>
> Fetch works the same way.

I'm sorry for being late to this discussion; I see the time and work
you've put in this and all the previous revisions. But I do have an
objection to implementing this behaviour using the option --summary,
on the grounds of UI-consistency.

I believe git users are already familiar with --summary in git-diff
and git-log, and it might confuse them when the output of --summary
for git-push and git-fetch looks different.

Also, I wonder what is the motivation behind displaying this
information. Perhaps you are including this to produce output for an
IDE? If this is included upstream, then I believe this is the first
instance of such verbose information being displayed. Even a
fast-forward merge (the closest I can think of that matches this)
doesn't show this - I still have to do git log rev1^..rev2 to see.the
intervening revisions (inclusive).

--=20
Cheers,
Ray Chuan
