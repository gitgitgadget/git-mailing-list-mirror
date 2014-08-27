From: David Turner <dturner@twopensource.com>
Subject: git fsck exit code?
Date: Wed, 27 Aug 2014 18:10:12 -0400
Organization: Twitter
Message-ID: <1409177412.15185.3.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMlQ7-0003VW-Hi
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 00:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935836AbaH0WKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 18:10:17 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:43998 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbaH0WKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 18:10:16 -0400
Received: by mail-qa0-f49.google.com with SMTP id i13so156451qae.36
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 15:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=CnF8y8ELJTjxHESnLBGn6RniLVmY0WmofBm0On+eG0g=;
        b=WVMY7HVeWgmXfwpw/6udxfe847NgkN2gLfAR/VTDAbysnRTMWiJh1jXICmwcX22RMB
         KtCPVzvIZPDvEKfp4qu4yw/WLfIuvhN7cBEhcI8Yc56WAifQAi+MJIxTkV+wHdxSaJ8Q
         Wd+MOet2bQsErvwM3gjQFcmAKSGC6LmJgiAf7+sQSghKqZTmpjUTSu9u25u03cdTCCzx
         CxvCEtaUYVSuw1EAWz/OeNlIw3G2JGT/Nj1ksLdMnqJRZJwfMNmIF/nbibKETYU0nB13
         PncGWFiqKPkrxEBdGKOc2ndscOPT1l4y5jY3+VhN5qrND69HDLJ0CsxSH2JIgvSi/azd
         qozg==
X-Gm-Message-State: ALoCoQmKPpnfjNAW9xHj0S0yIAVJvMSjnGOBL7CV0/VO3/Flyv25HCbGhmFLHMpZeigKTuBX0fnY
X-Received: by 10.224.64.201 with SMTP id f9mr65032758qai.64.1409177415070;
        Wed, 27 Aug 2014 15:10:15 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id g61sm2648780qge.5.2014.08.27.15.10.13
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 15:10:14 -0700 (PDT)
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256051>

It looks like git fsck exits with 0 status even if there are some
errors. The only case where there's a non-zero exit code is if
verify_pack reports errors -- but not e.g. fsck_object_dir.

Is that really the intended behavior?  I think it would be nice to at
least support --exit-code (but probably a sensible exit code ought to be
the default).
