From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Adding default remotes to a bare repository
Date: Fri, 11 Feb 2011 11:11:41 -0600
Message-ID: <4D556DCD.3050907@gmail.com>
References: <AANLkTikVtSFs+qRiWJwxre8urOJs7q2HXBGPZkiTmn=i@mail.gmail.com>	<4D5437C4.6000401@gmail.com>	<AANLkTimg0YZ7eQ=hsxqSYJPipahLpiqZqSVkFz25=A2k@mail.gmail.com>	<4D5460B9.9070300@gmail.com> <m21v3eojr6.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 18:11:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnwX8-0005Rs-PQ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 18:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab1BKRLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 12:11:46 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43715 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769Ab1BKRLp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 12:11:45 -0500
Received: by gyb11 with SMTP id 11so1166513gyb.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 09:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eWwS97Dy2+tebtskk355PpkUSPFYWezktHUugxgQ+Vs=;
        b=ezMTJxIQ33wGTnos1nSiF1oI2LQlKbe2pMOSUiaP0lUR/dP6GE0HdEdLvgiXoAkEVG
         5ZccbZwbcuN98kc3BT25ywJdEd3TpjVSuC6OqhjKAbHfP/L5C/YuDwymSQ3eVecsu9+m
         b/EiTyJwlxT2cPoaKnX2KL2F1BW/TqQsbSmQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=mlEkpqb1gBWTQwstfuGuU+7tAJ7/lv5yzR6YD6g4WYqKVryO8T2LSe+jyDXXi2mswl
         ABnzR/avFEvrHT1GXevvdYg0e6SP9DL1lepnIvhyYZwWUb4h2Jr41xkprvCRhRtHbO7b
         bowsy3aYN734gksRlXt5zZIPmcn6L+WjeDkwM=
Received: by 10.100.105.20 with SMTP id d20mr309042anc.260.1297444304670;
        Fri, 11 Feb 2011 09:11:44 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id b11sm1178770ana.38.2011.02.11.09.11.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 09:11:43 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <m21v3eojr6.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166564>

On 2/11/2011 6:09 AM, Francis Moreau wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>
> [...]
>
>> you can do some hook setup automation using git templates.  see the
>> --template option of git-clone manpage and 'template directory'
>> section of git-init manpage.  There is some big reason why they don't
>> let you inherit hooks from the origin repo of the clone repo.  I think
>> its basically because you could have security risks or compromise git
>> integrity/workflow with hook inheritance.  If you look in the
>> newsgroup people have talked about this alot before.
> Ok I'll look at what have been said.
>
>> As far as your request for automatic remotes, a flaw in your logic may
>> be that you think the functionality you want would let you clone from
>> an already-setup clone (1) which points to remote (a) then the new
>> clone (2) would point to the remote (a) of clone(1).  Not so.  When
>> you make a clone it does get an automatic remote to the repo it was
>> cloned from.  This is called 'origin' remote.  Therefore, clone(2) has
>> an origin remote to clone (1).  Your idea on automatic remote setup is
>> in direct conflict with the way git currently does automatic origin
>> remote setup.  You can't do both because that would turn in to a real
>> mess pretty quickly.
> I don't understand your last sentence. Why do you think it's going to be
> messy ?
>
> Thanks
you're wanting the remote 'origin' of the clone(2) to be the same as the 
remote 'origin' of clone(1), ie. remote(a).  However, the git behaviour 
is that if you clone clone(2) from clone(1) then the the remote 'origin' 
of clone(2) will be clone(1).  The repo you cloned from is by default 
the remote 'origin' of the new clone.

However, you can create a config file in your --template dir that has 
the definitions of these "universal" remotes you are wanting everyone to 
have.  Then specify that template in your clone command (with 
--template) and it should pickup that config.  I say "should" because I 
haven't tried this exact scenario.  I think config acts a little 
different via a template dir than hooks.  Try it and see if it works.

v/r,
neal
