From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 1/2] traverse_info: make mostly const
Date: Mon, 21 Dec 2015 18:15:14 -0500
Organization: Twitter
Message-ID: <1450739714.3892.2.camel@twopensource.com>
References: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
	 <1450737260-15965-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 00:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB9fq-0003RH-BK
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 00:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbbLUXPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 18:15:21 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34956 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbLUXPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 18:15:18 -0500
Received: by mail-qg0-f49.google.com with SMTP id o11so42890599qge.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 15:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=uJeoSxT+b+8hgs6F/iAGsKf1weZonGXzh2ntrwTrBAA=;
        b=vM3afGYUeNgfIjA3AUBzJI/hekmMm7i8tisGiTBBFAMvqN9OxXQcFyQCw06XliSYQ0
         x+E1hSinmeU6Hpbfss6WJe75XluBABqHPOme2yjvoT5RSq2TWb1dX1IarQmGhFkjPmtS
         HMBMIiCIG8LlohFRCtGPX4wsrO81bHnEzFv2Zyo/1lSzpb8AdzuKJuPSVkn9iWmCRH9Q
         dOhApJ88/LpltTCldTFxHE/GQQmtUaiZ0qaMkuWfawnNnAHeEyFEFj6qZbvcufCAQNQg
         zfM0LysjumDQwuZWqW6hA4MdkqB+Dnfp7TExnM/2Y16otmyoxlKNXjFPVtcLdlZl/mzG
         IU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=uJeoSxT+b+8hgs6F/iAGsKf1weZonGXzh2ntrwTrBAA=;
        b=AJKHyQ+tMb8KSEcaA7Tnb70ktfW209aInbxqO1JqDMrEVs9F1aSqoK1Sv9fcIf8/g3
         SIrx3xf0hw+tSty5daIPIoqoWRG9koPMQSj9tp4/BmehezYy0F/wEFwr6GZa2Ns/Iv7s
         CyNZZRfUyZ/n7M7wlZOJeJ2EmH1Fm562a/raY8mALl+nfr/pCPGdIqka7I5ffCXPIePI
         87ExO0KGkM65bridGS4S5+iuwnz6GuFaJV03ZCZaIufkiTuks/SErAkXBX1H4EYo3ioA
         w0873GAOeomxgSqkYLMiCsRMZkfb2dK17crqsAsxBYaM5PkwX9r5OOCoEs1VlDzg02Uv
         gN5A==
X-Gm-Message-State: ALoCoQmum2PYSgotqXkAV0niKgIHgU4etTnhB5UxHvYg33zPbCWNX1QpXW+RZIprPEMplWq3DBcmkgfxvOmPo6tsuRnepCvVlA==
X-Received: by 10.140.158.4 with SMTP id e4mr30350567qhe.81.1450739717378;
        Mon, 21 Dec 2015 15:15:17 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id v138sm15059354qka.6.2015.12.21.15.15.15
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Dec 2015 15:15:16 -0800 (PST)
In-Reply-To: <1450737260-15965-2-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282823>

On Mon, 2015-12-21 at 17:34 -0500, David Turner wrote:
> We don't usually modify traverse_info, so make it const across a wide
> range of functions.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/merge-tree.c     |  2 +-
>  cache-tree.c             |  4 ++--
>  cache-tree.h             |  2 +-
>  t/t4010-diff-pathspec.sh |  2 +-

no, that change was not necessary at all.  
