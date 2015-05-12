From: Luke Diamand <luke@diamand.org>
Subject: Re: git p4 clone - HEAD + partial history
Date: Tue, 12 May 2015 20:55:05 +0100
Message-ID: <55525A99.9070702@diamand.org>
References: <CAFcBi8_sARUkD2iDeto2CXr1vOm473aOSbj9dCiERTj51ot59A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: FusionX86 <fusionx86@gmail.com>, Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 12 21:55:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsGHI-00012f-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 21:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933523AbbELTzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 15:55:40 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:32928 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932707AbbELTzk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 15:55:40 -0400
Received: by wgin8 with SMTP id n8so21853208wgi.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=WMpAddyqRnDeXSAFpYA4xeXc4RayFp3GfoCo6cak4B0=;
        b=bTKG8wJ76fM5F20HCQdoVrJrVy9b3xZ7syAp0nYTm12zz1SwP4qO/AfaZ0DH4VvUtB
         pUI8pmzHVxmc4Na2DFbFkP7uJWkpPrk9y5hvFCkOaRisGPs7UxN3uCmdqeyqgBzf/i+z
         /bTZx7OvN7icMNF4hklxLsTeU4vK/ZQZF9ZUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=WMpAddyqRnDeXSAFpYA4xeXc4RayFp3GfoCo6cak4B0=;
        b=DBJDvDnJmfX4E1I4n+3c/PeDFFV1AEmwq6eGDCnS3FJaAkb55upgCjo5YQxF4bQgE+
         xTQ0g5FRR70ArrnsvSXQZDyuJLZRpK+m2wfyedI74BMA89T5KwHaLpEn0undSlIWWvMo
         iaeQizeO0NstUxEO+tDQT3azE/7oHEL3X7OC/xm3gYw500wuVn8RZdxBbj9Nrf/F1Kqt
         K1ao1aB/H46/UMSPuXpTMWg4eUeIiJOBXugocODGSbw+G+eQBFnLDPbmwvHBwXDfjTTH
         lexxl+ReiIUEFRiecB7ruuNIb1zsk3Y71mD0n7RG+99eRD6IXyS3WPezs/yNk/GBWxQC
         TSmw==
X-Gm-Message-State: ALoCoQlyIW0WXwbVhz+sZI+6sr8Lse9p30y80+sjDua4xzUaJ/h91XleF3cTiWz0bAWU+dRRg0bZ
X-Received: by 10.194.209.168 with SMTP id mn8mr149075wjc.49.1431460538857;
        Tue, 12 May 2015 12:55:38 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id ez19sm4392514wid.19.2015.05.12.12.55.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 12:55:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAFcBi8_sARUkD2iDeto2CXr1vOm473aOSbj9dCiERTj51ot59A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268876>

On 12/05/15 20:31, FusionX86 wrote:
> Hello,
>
> I'm migrating my company from Perforce to Git. There is history in
> Perforce that goes back to 2006 and I'd like to migrate it with some,
> but not all of the history. I'm not having luck so far.
>
>  From what I see, a simple git p4 clone grabs HEAD only. Using @all
> grabs all history and is way too much to migrate. I have tried using
> //depot/folder@2015/01/01,@all when cloning, but it doesn't grab the
> current stuff in HEAD.
>
> Is it possible to grab what is currently in HEAD and the last few
> months of history only?

What I've done in the past is just find a commit that's about the right 
date, and clone from there.

i.e.

$ git p4 clone //depot/folder/...@12345
$ git p4 sync

The usual problem I have after that is that P4 repos can get very large, 
and the process can quite time consuming....

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
