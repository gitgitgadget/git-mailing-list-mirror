From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Tue, 10 May 2016 13:52:10 +0200
Message-ID: <1462881130.3018.13.camel@kaarsemaker.net>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
	 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
	 <1462832134.24478.49.camel@twopensource.com>
	 <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 13:52:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b06D6-0007Jt-1V
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 13:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbcEJLwR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 07:52:17 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34954 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbcEJLwP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 07:52:15 -0400
Received: by mail-wm0-f48.google.com with SMTP id e201so174439593wme.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BICVQB1uAyv8ynWJuhPjGjuOhatPkwHbJO5FkAHpGaE=;
        b=cyB56eTT+F9rX1o0VBEDlekpx8ALWoVQPHujDS2ksCsDVmt9Hh5BQswNUvcEy3hr4C
         khin/Ihun9WBDK1ob4r6SzCRkDk+rRYlH7WnNx+ZB3kfmmSDq6JvzhxDtiIfrcSHc+4D
         8ja5QBBX60WyGgsDTyPM/uTr8uCcetw3MVTfQmNehsYNFlDEkYSh2toa5pbyngT+dFAQ
         wXbo/+dhvjgL+H1FXTQJ+Eq0gO2LYyAn3Cv9pmqH6bXcU7e17BAh3unbWiI9BvVcRJBl
         pc+Xbi12svWwrWKGkTq2pkPbDJVVpM4+Eak1OepW/fCahV82ocIOh4FTwjIeGPDbgSLL
         Mckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BICVQB1uAyv8ynWJuhPjGjuOhatPkwHbJO5FkAHpGaE=;
        b=IaHt+4q+nHHaCuls4+ahVyglqEWGkdQJw70EYBihe2h1tyF0pReCiuzj7j+LMShMGo
         jSiFqB1wAtjFJSczmpSKVmRUBpjvRJ2rDRT6sTHh1uPE3t8C0NYZZsOVX5OEw20Dl1e5
         mRX6wqWaN5eZsnHH088oDjws8MuAECu++d9Pf23rV8hQTamC0ytKD5o6GXJEqhNQ7JXz
         PLMCgZbbKq3DjGfK7rYn+RTYn796w2qo666SfGepHKhfJe6j3Fq0o7uIfpzkYWGsc9bY
         3lg525aHX4aarMkxqR88Hk3k4J43CDgv0FzJWjjJ3zfSs8fBBnZY/bU4ESv6KVWf6duo
         bBbg==
X-Gm-Message-State: AOPr4FXdPqSuQfdYijULff+XxtGuI8oXtwzc1fRgLT6m3cKN3obHxqp2ZGVXuKsB0LAfQQ==
X-Received: by 10.28.154.2 with SMTP id c2mr16976127wme.9.1462881133794;
        Tue, 10 May 2016 04:52:13 -0700 (PDT)
Received: from seahawk.local (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id v9sm2147178wjt.1.2016.05.10.04.52.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 May 2016 04:52:12 -0700 (PDT)
In-Reply-To: <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294120>

On ma, 2016-05-09 at 15:22 -0700, Junio C Hamano wrote:
> It passes on one box and fails on another.=C2=A0 They both run the sa=
me
> Ubuntu 14.04 derivative, with same ext3 filesystem.=C2=A0 The failing=
 one
> is on a VM.

Same here, except=C2=A0ext4 instead of ext3. Failing on a virtual machi=
ne,
not failing on a physical one.
--=20
Dennis Kaarsemaker
http://www.kaarsemaker.net
