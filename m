From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 32/32] tests: add ref-storage argument
Date: Mon, 29 Feb 2016 18:50:44 -0500
Organization: Twitter
Message-ID: <1456789844.18017.73.camel@twopensource.com>
References: <1456786373-6644-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:50:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaXaX-0000EE-GC
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbcB2Xus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 18:50:48 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34330 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcB2Xur (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:50:47 -0500
Received: by mail-qk0-f172.google.com with SMTP id x1so63273293qkc.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 15:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=aqS2f08gGwxcKJV94l/MjJ1JTQoodT8TtSB3HOygoio=;
        b=vVjMArQtz3Omx4LeiNHCLYSX67eeCuOCs13Z4hm/8sNvyE8YD5Ffefc+ahh82WbodW
         uUPkCo/MnqqbXOTxRU2URpMTQa09vyzfQ7FrCu/82eK8Nbngg1JmRMGK2RfNrKwJOn+7
         NN7TdiOlPkHtMiHq4WMgx6Z/E88ZhiCk7dlVdlz02Z20EBulTOQWDIf3lfB+o402/jSe
         jmqKTEW8/tBSDxXJdtfoktD2vh8KEvD6IUz/YM+/jzkNzzRdJ/AYm/F3KZqD70VpXACU
         cTnC1FagTTHcDOLoruICcvmO6Vkc27ljdmqy1OHY6eXRVbsjM8mPedPFfASujaNxkIVH
         +o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=aqS2f08gGwxcKJV94l/MjJ1JTQoodT8TtSB3HOygoio=;
        b=KJVCe6TX3bfj0kT5hOrSKy3+5UQJ4O1jsBoTlnwjBKi6zVHC1kmUhV9m7hrw1O2IW3
         GqT6/wRBtd9RbQrJRcDDDZ34Y6P4DpjxJmZwqrBZB3I2LQYnYZlLnKY9ficAI9ZeimFW
         gcela/PN0by8LDLDI1qSNpR/2X9Wq6jc13m7YMlrqVZCklE3ojhRXNPplK82NpcNpB9t
         iOTLUx7BqIfOh+GPkrz+LPJRwNrCoeZCjfnQTkAShHD2G1HB87kTPZ8nsOuTAxIS8Hgq
         6u/eGUyER2COegWwsozXzpXcugtOH1n9qsdbbwjkIvMVXPiKMY1smhJB5z+7oZVXvcgv
         Eacw==
X-Gm-Message-State: AD7BkJI3ZSkuVZgjXhcaAwd1Is2qUG+Dry+RmaBh2/LfixVgE3ZGnhAFKGke4O/kB/3NSg==
X-Received: by 10.55.43.35 with SMTP id r35mr22736263qkh.64.1456789846138;
        Mon, 29 Feb 2016 15:50:46 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id y99sm11956266qge.3.2016.02.29.15.50.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 15:50:45 -0800 (PST)
In-Reply-To: <1456786373-6644-1-git-send-email-szeder@ira.uka.de>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287942>

On Mon, 2016-02-29 at 23:52 +0100, SZEDER G=C3=A1bor wrote:

> As far as these tests are concerned any subdirectory under .git/
> would
> do, it doesn't have to be .git/refs/heads.  How about cd-ing into a
> different directory instead of creating the missing ones?

Good idea, thanks.
