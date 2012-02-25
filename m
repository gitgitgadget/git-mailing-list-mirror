From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git compiled on same distro, different versions
Date: Fri, 24 Feb 2012 18:05:30 -0600
Message-ID: <4F4825CA.1060506@gmail.com>
References: <ji8u2f$gml$1@dough.gmane.org> <7vboonhoko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 01:05:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S158s-000756-Eo
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 01:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab2BYAFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 19:05:30 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51786 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab2BYAFa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 19:05:30 -0500
Received: by yenm8 with SMTP id m8so1425465yen.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 16:05:29 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.125.130 as permitted sender) client-ip=10.236.125.130;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.125.130 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.125.130])
        by 10.236.125.130 with SMTP id z2mr8747968yhh.94.1330128329520 (num_hops = 1);
        Fri, 24 Feb 2012 16:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1kVmJjsOJKjzKaA6S0LbBwAnObfh7xNB4caF1vT63ss=;
        b=UW9G1dmlwyvrz51d75eBhjTNrpCY0BGbLTnyRycQwMr+0/zaAc2omX1RYz5e4v/LpC
         Hv/CUpbwU0GsQ+ycl3urrQS9ffNlrMcHbcF993LAF8LPakZCogb34uDF9NIFQQKppNUt
         VuEhDPrW64Q9kDoe4cJR6+6oBtgzN8mdTPt70=
Received: by 10.236.125.130 with SMTP id z2mr6634549yhh.94.1330128329472;
        Fri, 24 Feb 2012 16:05:29 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id e45sm16423105yhk.2.2012.02.24.16.05.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 16:05:28 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7vboonhoko.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191502>

On 2/24/2012 4:08 PM, Junio C Hamano wrote:
> "Neal Kreitzinger"<neal@rsss.com>  writes:
>
>> If I only test a new git version (compiled from git.git source) on RHEL6
>> before I put it on the RHEL5 box is that sufficient for validation?  Should
>> git behave the same on both?  If not, why?
>
> I somehow find this a strange question to ask to Git people; you may have
> better luck asking the question to RHEL folks.
>
> Having said that, one of the reasons the result may not work, off the top
> of my head, is that the binary you compiled would expect to link with the
> system libraries that are available on your RHEL6 installation.  If your
> RHEL5 installation does not have a matching and ABI compatible library to
> any of them, the resulting binary would obviously not work there.
>
"high-level" question:
If I compile git 1.7.9.2 (from git.git source) on RHEL6 test-box and 
test it and conclude that it "works right" is that sufficient for me to 
then go ahead and compile git 1.7.9.2 on RHEL5 real-box and 
expect/assume that it will also "work right"?  IOW, will they produce 
the same results?  Because if not then I have just potentially broken 
the real-box.

"low-level" question:
I suspect git calls linux commands alot.  Git has "plumbing" commands 
that are not supposed to "break" scripts.  Does linux also have 
"plumbing" commands that are not supposed to "break" scripts?  Does git 
only use linux "plumbing" commands?  Because if git commands uses linux 
"porcelain" then the linux "porcelain" change could cause git to change 
(not necessarily "break").  Maybe git-porcelain only uses 
linux-porcelain, and git-plumbing only uses linux-plumbing.

Definitely thanks in advance for any replies!

v/r,
neal
