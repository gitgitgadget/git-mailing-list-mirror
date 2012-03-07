From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 06 Mar 2012 19:11:12 -0600
Message-ID: <4F56B5B0.5040204@gmail.com>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>	<4F567DC6.4070903@gmail.com>	<4F567FEF.5000105@gmail.com>	<CAC0z1F_eyMo4D8E2j15dOFhp-6tZ_ixacB6XcKfNpJategcsXQ@mail.gmail.com>	<CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com>	<CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>	<4F569EA8.4050907@gmail.com> <CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jerome Yanga <jerome.yanga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:11:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S55PV-0002vK-Gp
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 02:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031750Ab2CGBLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 20:11:15 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46982 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031740Ab2CGBLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 20:11:15 -0500
Received: by ghrr11 with SMTP id r11so2654385ghr.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 17:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=31xD3SIi32piMiTVOfOaJyATSluqhLdf1N3nWiGOWmk=;
        b=kmdzZFPCC1jEpWLsU7tq5HliNXNETBQMAmfheKpYijTWHvz20H52nK61oOWhU+3P53
         ozg+vHG+jXRptkEYTMsCq/KlIMipn08wZLvXntCvq13Uo72CbzTKag0gRYTo8/6Vp4BR
         oZjoECLQ4wthfARy91OG4WN7+HBlbreXEanjpMFztgqU7eRtA+PQgp7ucc19RVtdRzxN
         9dtOFlcRun4oVekh5dXCZLTS/JKPGDnHnd1gKLDt4A0ZvXm7VZxqLFV0Ta2tB+m3TFzV
         kn0qTdN63bWsaz3Odwb/4wrdGgyisC8oR/KmmlCYwHdM1j5ZRxHSrxeJCgfY/idpJSlT
         agvQ==
Received: by 10.236.78.6 with SMTP id f6mr176925yhe.109.1331082674367;
        Tue, 06 Mar 2012 17:11:14 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id v26sm53737858yhk.1.2012.03.06.17.11.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 17:11:14 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192420>

On 3/6/2012 6:28 PM, Jerome Yanga wrote:
> The project in Apache's DocumentRoot was created using the following command:
>
> "cd /var/www/git
> git clone --bare<non-bare working directory>  <project>.git"
>
I have a comment on the above command.  Did you run:

git clone --bare /non-bare/working/directory project.git

(or)

git clone --bare file:///non-bare/working/directory project.git

because the former does hardlinks and the latter does a full copy (see 
git-clone manpage section "GIT URLS").  I'm not sure how much it 
matters, but you should confirm whether what you did is what you want.

v/r,
neal
