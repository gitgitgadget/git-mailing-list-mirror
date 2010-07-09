From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [BUG] git-1.7.2-rc1, cherry-picking with gitk
Date: Fri, 09 Jul 2010 14:27:50 -0700
Message-ID: <4C379456.9030401@gmail.com>
References: <4C3792E6.5060302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 23:28:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXL73-0005zg-Up
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 23:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab0GIV15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 17:27:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45756 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab0GIV14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 17:27:56 -0400
Received: by pvc7 with SMTP id 7so1016434pvc.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=zJJK0wlhMyCs6KsN/b5Rnu88Kgaolx9t6Fb2vyRvr1E=;
        b=YIV6VDYo1p+/rZz+2zARs3XdZW5RdreBHB5UWYs2C81lwOMqjZkvnWUIdSoMc7KiBB
         4ALHWHB1baoED1uwWEyau/2BRiChCWAsmJtUshAN+Du9XwEWrhAwxUdljbnB5JPYFq7+
         UXEKLmW597PrIlVhR8CxkfHHR86v0JxNGP/Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=t9WDEj//QwZVBtU5gR7ATGhmoMdjJrvUMMScMotGUqOiV/WGpf99lj82VljejMZdeY
         KYIeXekX7I0Y47mamygMkOs59hg2ZMhiRpkEsUPBxK72oIABdJlHxVOE5g8fuShln6xS
         4x3ktu9yuIpEfMJECbqKdNI3m1vi3muyOYjTQ=
Received: by 10.114.111.11 with SMTP id j11mr11971512wac.142.1278710875477;
        Fri, 09 Jul 2010 14:27:55 -0700 (PDT)
Received: from [10.4.6.94] (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id q6sm19989811waj.10.2010.07.09.14.27.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 14:27:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.10) Gecko/20100520 SUSE/3.0.5 Thunderbird/3.0.5
In-Reply-To: <4C3792E6.5060302@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150690>

On 09/07/10 14:21, Chris Packham wrote:
> Hi,
> 
> Just noticed this when I was trying to cherry-pick a commit from one
> branch to another.
> 
> I launch gitk with 'gitk master..work' and right-click a commit to be
> cherry-picked. The cherry-pick seems to work (i.e. a new commit appears
> on master) but I get the following message from gitk:
> 
> can't read "circleitem(5)": no such element in array
> can't read "circleitem(5)": no such element in array
>     while executing
> "$canv itemconf $circleitem($row) -fill $ofill"
>     (procedure "redrawtags" line 13)
>     invoked from within
> "redrawtags $oldhead"
>     (procedure "cherrypick" line 46)
>     invoked from within
> "cherrypick"
>     invoked from within
> ".rowctxmenu invoke active"
>     ("uplevel" body line 1)
>     invoked from within
> "uplevel #0 [list $w invoke active]"
>     (procedure "tk::MenuInvoke" line 50)
>     invoked from within
> "tk::MenuInvoke .rowctxmenu 1"
>     (command bound to event)
> 
> I've been doing similar things with older versions of git without
> problems (technically I usually do 'gitk --all' instead of 'gitk
> master..work').
> 
> --
> Thanks,
> Chris

Just following up if I use 'gitk --all' I don't see the problem. I tried
git 1.6.4.3 and saw the same error message with 'gitk master..work'
