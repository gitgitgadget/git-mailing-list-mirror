From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: git branch based hook desigh
Date: Wed, 20 Mar 2013 09:46:32 -0400
Message-ID: <20130320134631.GA7325@google.com>
References: <148C5E2E-8FD6-4686-A009-57D1F403C808@infoservices.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Wed Mar 20 14:55:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIJTr-00022Q-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 14:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab3CTNyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 09:54:37 -0400
Received: from mail-ye0-f201.google.com ([209.85.213.201]:37674 "EHLO
	mail-ye0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab3CTNye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 09:54:34 -0400
Received: by mail-ye0-f201.google.com with SMTP id m12so153083yen.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=h1Xp5dj8ew/iikCvkewHLng7+fSBc7NUb99hUjGn+mc=;
        b=OckoEpYUOBjl+9LemxNH6TZ54BL7dpNUO3uDGutMSm0dmcnQABQ6xDph7zrjXiY3nw
         ncJvftDAckTKyQUr9Rq+OYeqexxNOl2tfC6BHwudmHFwjFbMPKe0CC7qdCvKnnQ8bGrR
         sEFlMDDzne+my5rAVZ8BT4t9v+LWWtZjjiQyvGNrabsWVeCT+/myYl/GVPu4Up2FAUrx
         lWpH27jYV6r8URLD/8QgSgwzVF2Zi+h1ihwmNH+7SLIs4bXHCxYb4NlWAwXtuRm8zYr6
         4VUH/qZjyENH+q2nuNGaMMB7s/n32Q1KG0mXh7s3rAO09D29moPTtUP3xolbNBkzfnvC
         TSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent:x-gm-message-state;
        bh=h1Xp5dj8ew/iikCvkewHLng7+fSBc7NUb99hUjGn+mc=;
        b=YOck9cB8/CbfBhF8nNdLbNDIa2TdBxPD1tPHv5lzpuOmNJzYgtOfBZHgTE7+4xjJwh
         MQKoDBxEB93l+wugnTRJ27qqhLaE0Z4oLbaYSBWF8n4zCyk9rVr38cIjJtSzhWEvzRmX
         K3epBM0bDzEi9VJshoPtvProHdmZ6L58ocsNIAgoed0VptifkAT+vdrQ2tPSNVV77DOu
         3t3ocT+F6W/S0o3USYTQfrx+18m54HzYXSJL3oR1OCAV9+g1v9MrAfPegFBbVMok9b+1
         2XyDZ3hfWfRYdPxA7Yf/T42PLk0x4rRHKp+OBYSEJfvsxY8tlt4PyvNZ9YR1BLIx0S9P
         91MQ==
X-Received: by 10.224.185.201 with SMTP id cp9mr3515053qab.6.1363787193165;
        Wed, 20 Mar 2013 06:46:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t12si1823459qcz.3.2013.03.20.06.46.33
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Wed, 20 Mar 2013 06:46:33 -0700 (PDT)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 02CAD31C25E;
	Wed, 20 Mar 2013 06:46:33 -0700 (PDT)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 9F95A407A6; Wed, 20 Mar 2013 09:46:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <148C5E2E-8FD6-4686-A009-57D1F403C808@infoservices.in>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQmZZGV/IsZBfOGjFxa9Pl3eX5gkSMb7bKrs3hexprwZy+HZaNxFNQExLReQK/r7NQrUVNbyKFXi03HYrU9OM7eR49/Uc+z4pTUxtlEaG5pmJsHjFpc4m/sf0xzC4TGhPBb2YfD2P+HYpte52jGtX3qhTtc0dilzT9iiWGFIufOsIIADUhigSfY/CnYG89u/hu6XZAwd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218608>

On Monday, March 18, 2013 at 00:27 EDT,
     Joydeep Bakshi <joydeep.bakshi@infoservices.in> wrote:

> I have implemented git pre-received hook successfully. And it works o=
n
> the repo level.
> Could anyone suggest how to call branch level hook please ?--

If you need to have different hook behaviors depending on the ref that'=
s
about to be updated, just put a conditional in the hook. You get the
name(s) of ref(s) to be updated on stdin.

--=20
Magnus B=E4ck
baeck@google.com
