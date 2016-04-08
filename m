From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 03/24] t1430: test the output and error of some commands
 more carefully
Date: Fri, 08 Apr 2016 15:26:17 -0400
Organization: Twitter
Message-ID: <1460143577.5540.11.camel@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
	 <1460055791-23313-4-git-send-email-dturner@twopensource.com>
	 <5707CACB.4030906@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 21:26:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoc30-0004FF-NI
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 21:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758841AbcDHT0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 15:26:20 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33305 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085AbcDHT0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 15:26:19 -0400
Received: by mail-qg0-f48.google.com with SMTP id j35so98818776qge.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :mime-version:content-transfer-encoding;
        bh=0GzbHXGBpeKhJcNQ6kDOohkUh/aNImRhZGfEYd1G1jc=;
        b=yxwKDZOddmsO4cRmBR0qjIZBLqvBcmHbaL5LtORN9mFdZQGJe6wVHI1+DVwfepmezm
         4lubi6bCBnkqVCTQjEwmbqh9Ol3ehF6oiR5LQesWUn/1V3+VgWdneuACORQy/bCVxqqH
         CeDLts6pSVMp0J+t+Ec1z2mSCG6+Tbbv2RYzSI7+3gvOD2uryPAuq7iiPqV0PzDC+fVI
         5Pp4IEHmwIMjGK7cUsp4CR49Nyvk4YSnpbpMSbwa+E9DXmdcZztDH2cAUKxZC5Ia6J3y
         gl1lgyFD1zXKAfS6JLzXSNwpbraBXX8NGDZfL2Z24RAw+xnVHc6ChEbHm4ygm0TGMDC4
         7TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0GzbHXGBpeKhJcNQ6kDOohkUh/aNImRhZGfEYd1G1jc=;
        b=Q+K320Jp7lMJjn5g3vaURGD5gC0b5HeGjscCPb7eOpVvT47rrzzcNwa3JtVvh/YvOI
         QZLFKDMrHfja4TUMgZLPm6uJMLMfN2v980kCmgF+GNH37sWIsba3NwvO2X7FsxF2PUOQ
         FAOvhCbmu+dnuYr2S8Ootwsq43PlxUBFs/TkDj1DsKI/+0vlHtdWSe+pjs2PzDCplkJ7
         2/zibY3F54Vq5KuRiygodBWBA7mdYS1C7fufH8wlr2IY+3vrI/ANIl4HGWXlUgF0VuqI
         RWhwrZxZ8ud2XapcPBVb5OFubOjMqCDb2wtHteRwaEuHPRoLVJAVpMy/zWBexfX48dC+
         GwQA==
X-Gm-Message-State: AD7BkJLMwFGQdvawhd1fNXqSa39CE5GW5a+L249rYmuyQvhtxO+ob/68RHMhSehY7K8W2A==
X-Received: by 10.140.39.232 with SMTP id v95mr13460846qgv.30.1460143578848;
        Fri, 08 Apr 2016 12:26:18 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id o111sm5174804qge.23.2016.04.08.12.26.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Apr 2016 12:26:18 -0700 (PDT)
In-Reply-To: <5707CACB.4030906@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291056>

On Fri, 2016-04-08 at 11:14 -0400, Michael Haggerty wrote:
> On 04/07/2016 03:02 PM, David Turner wrote:
> > From: Michael Haggerty <mhagger@alum.mit.edu>
> > 
> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> > [...]
> 
> David, even though I wrote these patches, I believe you need to sign
> them off too since you are the one submitting them to the list (it's
> a
> chain-of-custody sort of thing).
> 
> It's possible Junio would be willing to add the signoffs to the
> patches
> if you tell him "I sign off all of the patches in this series" but
> I'm
> not sure.

Junio, I approve signing off on all of these patches.  Would you like
me to re-roll with my sign-off, or would you prefer to add it yourself?

Thanks.
