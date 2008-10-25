From: William Pursell <bill.pursell@gmail.com>
Subject: Re: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Sat, 25 Oct 2008 11:11:14 +0100
Message-ID: <4902F0C2.2070709@gmail.com>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org> <1224583999-26279-2-git-send-email-charles@hashpling.org> <48FDC1CA.2080800@op5.se> <20081021122655.GA29294@hashpling.org> <20081022211720.GA23146@hashpling.org> <7vr668tdvy.fsf@gitster.siamese.dyndns.org> <20081023064455.GA10675@hashpling.org> <49024CF1.5040406@gmail.com> <20081024225539.GA6119@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Theodore Ts'o <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 12:12:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktg8I-0000VU-VV
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 12:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYJYKLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 06:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbYJYKLV
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 06:11:21 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:29658 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbYJYKLU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 06:11:20 -0400
Received: by ey-out-2122.google.com with SMTP id 6so480684eyi.37
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=yQ82odQK7m+8iehC+hgCb1rM5QBbxxoM3fvBBzjS+lY=;
        b=Eh2+/sI3CMe2aaSoDbonuDISS6LZUHBhb8vV9WUPnPtbXndFbxVGxiV2j2582iOA9F
         gM1BPZJ9n5etmMb8bcTOYgRseTBwjz4cuKBsgjxo5He5hC+d/e5wO4jhfmpT13ZpLgjO
         8UkYNicU5jdFnKZVa+qnpgT/oMTkPUSRstVjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KWEuRSNFWqywhYqE6VPx5c88CPB2G5BEPxhjNdFCZhskgnNrxsvtRytWpcNOnu+JZK
         Gon47XWAIK+Ajs45VsfFk8Lh5SYVSKmfCC+J7V7JHNm2zdz4C9bVB/amym9vfMMjZXfs
         Hq1TFGm1pN9Z0jJpEslu8j2cYig6f4hSjhSCI=
Received: by 10.210.59.3 with SMTP id h3mr3595562eba.150.1224929478783;
        Sat, 25 Oct 2008 03:11:18 -0700 (PDT)
Received: from clam.local (5ad934ac.bb.sky.com [90.217.52.172])
        by mx.google.com with ESMTPS id g9sm2525598gvc.0.2008.10.25.03.11.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Oct 2008 03:11:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
In-Reply-To: <20081024225539.GA6119@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99101>

Charles Bailey wrote:
> On Fri, Oct 24, 2008 at 11:32:17PM +0100, William Pursell wrote:
>> If the short option is dropped, the config option should
>> probably associated with mergetool.<tool>.interactive rather
>> than mergetool.interactive.  (s/interactive/whatever)
> 
> I'm not sure I understand your reasoning. The no-prompt/interactive
> option affects the behaviour of the mergetool script independent of
> which particular merge tool is being used. Why should the presence or
> absence of a short option affect whether the config option is global
> or per tool?
> 

My thinking is that when using an interactive tool
like vimdiff, the user is probably not going to
care as much about being prompted, or may prefer
to have the prompt in that situation.  However,
if they've written a script to do the merge
non-interactively, then the prompt is undesirable.

So a person might want to be prompted with
git mergetool -t vimdiff, and prefer no prompt
with git mergetool -t my-script.  Being able
to configure the behavior on a per-tool
basis would allow that.

-- 
William Pursell
