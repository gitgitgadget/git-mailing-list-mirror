From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 12/16] index-helper: kill mode
Date: Tue, 19 Apr 2016 18:14:41 -0400
Organization: Twitter
Message-ID: <1461104081.5540.130.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-13-git-send-email-dturner@twopensource.com>
	 <CACBZZX4VxyrO+B+MQYbR32-Dp_KpEABeFA67g22DNzX-YKzmXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Duy =?UTF-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.co>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:14:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asdv4-0005k6-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbcDSWOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 18:14:45 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34687 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbcDSWOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:14:44 -0400
Received: by mail-qk0-f178.google.com with SMTP id r184so9241032qkc.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=l91Lb1p+hlgONPeSL27vcC93Wn1mY31n8lxn6+a56c8=;
        b=K7T1w/M2SrfCSHY3UsgbcaHpdIMUj9OwdenqlqvE2cSQIeLLkODRIicvb7L2XULBhT
         oVBhkbGrkLssslUWBUrDYFb8WzyTg2INSkBzbHk4NxfV7ZugiCYVf+8gFy7FC5tGhcmq
         Jf8/dp9LL0Bmcctxl2GmPZYjtQ2ukJJJtmdcKGiCU8dYOwbXyTUsOM4uCZOA+w6xeejF
         Z5uCoBMZmBbwYET1Ms3MmmdcfrP10TaUH6yY6qX5ayc8CVSLGo5KYntoiqon0QezLhua
         C5vWPUs3aPoZnZoMEfGJ1oX2jeYVdfxzadaGKde4EukQluuKWliAFU32Pc4F8vspbGjS
         5hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=l91Lb1p+hlgONPeSL27vcC93Wn1mY31n8lxn6+a56c8=;
        b=g33xepW46toKPHqkp2ZB9Gk+UDhmgcCXfMINJuvFPxqzl5LkhV+d+X+6XtGlchQXYS
         C3bhDNTRDsi1lFdxch9S1vZ58BX0T8pciCUZeZX13fFTHC/NDC+mfERxFW6NYBkqgQTC
         1llKBQTRW0Wj5oph9BbRDSvas6krAp1FvyG4Mt3MwBue65T2C+PR1DjxuhUJ619oXmJW
         4A5X/dgzF9IjzfTapdF/lIDAV3yP6Ebnj+DY4rlV0x/pdM+fMyQrMI1redCt+7kOroYt
         pO5Got60o4smef75mDeHGvpOLJmCsdVdf1UaguDaS6lbqIJH74WgHrzcRb2pkRs2IyO/
         Ndsw==
X-Gm-Message-State: AOPr4FUJqPQArMSH6hiJSlBCptHRH2D6IKa+ZMZyZGvYqIhrVfgCk8/PzSauGttbp4wLDg==
X-Received: by 10.55.210.66 with SMTP id f63mr6866256qkj.25.1461104083163;
        Tue, 19 Apr 2016 15:14:43 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id o24sm14923773qko.32.2016.04.19.15.14.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 15:14:42 -0700 (PDT)
In-Reply-To: <CACBZZX4VxyrO+B+MQYbR32-Dp_KpEABeFA67g22DNzX-YKzmXg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291938>

On Sat, 2016-04-16 at 18:08 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
> On Wed, Apr 13, 2016 at 2:33 AM, David Turner <
> dturner@twopensource.com> wrote:
> > Add a new command (and command-line arg) to allow index-helpers to
> > exit cleanly.
> >=20
> > This is mainly useful for tests.
>=20
> Both --kill and --autorun are missing documentation in
> Documentation/git-index-helper.txt.

Will fix, thanks.
