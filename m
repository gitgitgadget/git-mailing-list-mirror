From: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Subject: Re: [BUG] can not escape sharps in git config file
Date: Tue, 24 May 2016 13:23:31 +0200
Message-ID: <574439B3.9090308@gmail.com>
References: <57442992.6030306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 13:23:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5AR1-0003Ws-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 13:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbcEXLXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 07:23:35 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37599 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbcEXLXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 07:23:34 -0400
Received: by mail-wm0-f54.google.com with SMTP id z87so19750792wmh.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=4/6MItP49YnWjrMCKHVIFye6J0CZSSa1JbkGrB/vqgs=;
        b=vOhqAFDej66lSUJt/y09U3x8EEYyWujI+NnzH4Wp4P8kZX25rSzqdeWB7PcIq5iZOT
         /fAecXAbXfiTdKACF38xwta8ybnly/HRTrT4XgnTMBqjmREMTKQRlbCccX3L9Y1jqXpi
         lfbKN3VgyOL+NjJCbTsOKeJQd9yRnu+mPk8Qjn5erWALJBD+h8L4T3MZ7RV/qtK9c+i7
         f0BxjByZPRyFYC9v2lQp+GX8E76eSiZV0Pupxqc8NHGc/3UL+R+hlbpcqI9+kP+37/tP
         7IItRQ+wbxK9pCn41XCFVbKout+k2N0sDnfFmWL5iPZL+Wif1bH5WhCMoa/+XrCGFaYK
         q2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4/6MItP49YnWjrMCKHVIFye6J0CZSSa1JbkGrB/vqgs=;
        b=TUNg9T9Ggf9DAOB4wCj2m3aJ7BDOGp/jrUMUL1ShrMg9ieoN3B7M0WHsYZIgvuVLSS
         Om6Fe6qJ/uFgGRbycKpuMw5bLJjG5UcfxMjdssULGpXuc6+63oOQtBVSCTyi8/4TwW7b
         tzLG5+67/QSJN/mXThP4+qswyqdb6cIpKgsTZAL3pgW3xVvRNKLTlpVqkxSIPaQwLxar
         nuxms26+1pZdGrxILO+dV8Mp3tQSotZ689FWXnmFjtE4ThRCgz1WGvrvq6msPdA9BA+/
         ZiW0IZRPx9mfpTgRcAtYMdjocE1wxRnGoEe/C35Av3ytqdfyRFjOqitVH1DE6zcdVI61
         biSg==
X-Gm-Message-State: ALyK8tIHO7Uj+zke21lbsyk0YXRc4df2gInczBv6/v680kTxkpEKkS7jbEn9d7v0IB//2w==
X-Received: by 10.194.10.69 with SMTP id g5mr3726803wjb.7.1464089013090;
        Tue, 24 May 2016 04:23:33 -0700 (PDT)
Received: from [192.168.1.75] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by smtp.googlemail.com with ESMTPSA id kz1sm2652696wjc.46.2016.05.24.04.23.31
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 04:23:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <57442992.6030306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295486>

My mistake, sorry for the noise,

JFTR:

 * only double quotes can fully escape a string (it is safer to enclose
the whole value in double quotes)
 * backslashes have to be doubled because they are interpreted by git

So

[filter "kicad_sch"]
    clean = "sed -E 's/#(PWR|FLG)[0-9]+/#\\1?/'"
    smudge = cat

JN
