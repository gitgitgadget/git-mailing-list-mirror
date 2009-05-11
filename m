From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: merging multiple commit into one?
Date: Tue, 12 May 2009 00:36:06 +0200
Message-ID: <200905120036.06965.jnareb@gmail.com>
References: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com> <m38wl3n3zj.fsf@localhost.localdomain> <4A08A291.2060009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: MALET Jean-Luc <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 00:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3e6i-0006vz-GN
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 00:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120AbZEKWgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 18:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756913AbZEKWgN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 18:36:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:16643 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621AbZEKWgM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 18:36:12 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1025076fgg.17
        for <git@vger.kernel.org>; Mon, 11 May 2009 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MSnEJ1X2lMvHBwmaiUP2dCY3mw+ntDJ2kHqXEQ8wWMY=;
        b=J7okn+9zaQBgPau//XjIuermKKa0FYmS+hS5g9NjptCEEqQ7qUGDCSvzwthJaRGwAA
         sxpBhat2f7Bk9+kuMCYwasY8n79cmaZ3knxEROdbHxnP36k3dB1LkIRY4SLte6T7RF0T
         zHWRd2kdbXyktoEozbl4ktb0LiEcaE3u2V8R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZIp4HFtjmnyLU3xhfNFQmtPBJgd9Jdpw71Q959udFdlJOJFR3M4/Q0TvG2yC+egg4v
         QvaLq5GvUNalDYTzhQoEzXbN9I07/mP5Jpyc+fzwcv+7S1D4t6lkXycI/iYp0p/GPgDx
         zzkug2CvTizri2L+xkikT8RP33MnHAirKmaf8=
Received: by 10.86.51.2 with SMTP id y2mr7043637fgy.3.1242081371223;
        Mon, 11 May 2009 15:36:11 -0700 (PDT)
Received: from ?192.168.1.13? (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id d4sm7695443fga.9.2009.05.11.15.36.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 15:36:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4A08A291.2060009@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118858>

On Tue, 12 May 2009, MALET Jean-Luc wrote:
> Jakub Narebski wrote:
>> jean-luc malet <jeanluc.malet@gmail.com> writes:

>>> I often commit "useless" code, for example before going into weekend
>>> or for saving some state during a dev process
>>> often thoses commit are simply useless and the commit message looks
>>> like "COMPILE ERROR - temporary save .... "
>>> at the end I have LOT of theses commits that are useless and I want to
>>> save some space/time/tree complexity merge multiple sequential commits
>>> (without branch) into one
>>> is it possible?
     
>>
>> It is possible; one solution would be to use "git rebase --interactive"
>> and its 'squash' command...

   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   
>>> according to my knowledge of git, removing the commit and rewriting
>>> the last commit log so that it better reflect the modification will do
>>> the job but I'm not sure git allow it...
>>>     
>>
>> ...but you can simply pick up where you saved snapshot by using "git
>> commit --amend" (or doing soft or mixed reset to previous commit
>> before comitting changes).
>>
>>   
> hi! thanks for your answers!
> I didn't knew about --amend for commit, will certainly use it...
> however it seems that I get missunderstood...
> A-o-o-o-o-o-B-o-o-o-o-C
>                       \-o-o-D-/
> let say I have the above tree, o are temporary unbuildable commits, A B 
> C D are usable versions
> I want as posteriory remove the o to get the following tree
> A-B---C
>      \-D/
> in fact I just wanna clean a little my tree since I forgot to amend ;)
> is this possible?
> ok I know, the best is to prevent! not to cure! so I'll amend ;)

As I wrote above, you can use interactive rebase to clean up history.

-- 
Jakub Narebski
Poland
