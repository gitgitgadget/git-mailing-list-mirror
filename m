From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Ignore version update changes on git show report?
Date: Fri, 01 Mar 2013 14:33:23 +0100
Message-ID: <5130AE23.4040303@drmicha.warpmail.net>
References: <DEC76CB0-9E35-40A8-9D73-77617CC605A3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Preben Liland Madsen <prebenliland@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 14:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBQ5r-0000rq-Kc
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 14:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970Ab3CANdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 08:33:22 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41055 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863Ab3CANdV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Mar 2013 08:33:21 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 917E5207DA;
	Fri,  1 Mar 2013 08:33:20 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 01 Mar 2013 08:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Qr3s8n6Osye6j7giDNXZw7
	vcDmg=; b=fxe6FXzyxaSIZRwZdecucf9kpEMOMkB2a+GW34p80Z5WnXF1xyKdyV
	CADhMGqrAGZEjfXw6Jrk2yYKkFtjaqYi/sCsaOFKMZf/o8DxMOxamIhnkVfBhOc4
	h9tmbwjpktO7xBtiFSTP6nT3T1B7BoTclUVPkjHdfx/epSyVyu+VM=
X-Sasl-enc: 5p5ex1CpHasrsILFFcM5Pv1aDWJS1EzKhOcqij/WOf1X 1362144800
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 13931C80E8D;
	Fri,  1 Mar 2013 08:33:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130219 Thunderbird/17.0.3
In-Reply-To: <DEC76CB0-9E35-40A8-9D73-77617CC605A3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217277>

Preben Liland Madsen venit, vidit, dixit 26.02.2013 20:53:
> Hello, 
> 
> I'm trying to investigate some what changes have been done between two versions of a software with the name IP.Board. 
> 
> This proves more troublesome than I thought, since their release builder appearantly updates the version number automatically in all files. 
> 
> This causes a lot of files to have this as the only change: 
> 
> - * IP.Board v3.4.2
> + * IP.Board v3.4.3
> 
> Which is quite annoying to have to go through and therefor is responsible for more than 800 files being changed. 
> 
> Is there some sort of git command or command I can combine together with git show that will ignore files with only these changes? Something along the lines of ignoring files where the only change matches this change or ignore files that've only gotten 1 line removed and 1 line added? 
> 
> Best regards, Preben--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

First of all, there is

git beat-with-stick

that you should apply to those responsible for that mess ;)

If you have to deal with that sort of situation then a textconv filter
might get you as close as possible. Use "grep -v '^\* IP.Board v*'" as a
textconv filter for those files, and those changes will disappear from
the diff. (I do something like that for tracking my gitk config, which
stores last window sizes.)

Michael
