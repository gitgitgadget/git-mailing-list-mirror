From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/16] git-sh-setup: make usage text consistent
Date: Sat, 23 Feb 2013 16:25:09 -0800
Message-ID: <20130224002509.GG3222@elie.Belkin>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PPT-0001pM-9A
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759399Ab3BXAZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:25:16 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:34975 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759392Ab3BXAZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:25:15 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so929528dak.39
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uZHjso1cdPJv8/vADJ6KMIDdc/rgX6UZarxX1wrp0us=;
        b=zzmTLJzf2aUgNKvIts2Pn6EpvlGTiZkFz4K8c1jQnSDwU2wXTBqFMUqTQV54+Bl2CK
         mOrCwyDasZevkx+XPYiSRnMAaBvAFmWRPSKx4UnwwMHjt5vR8STbufCWwXHvJDZMJ19c
         crj4lE0XFDTLnneFF+I21raZ5lClbTjhL0Z1KLwP9oDou3fnYjK+cYRC5xh1pN3SXSTA
         6PMeXBl+5itJGqeXra13WQqjuNpr5SkjTCy2/InacdK+oisxpiyYBst3195aVTy10FTI
         RiTZaFTmw5RWnSMFCaGEJPSBKqw9L70X1SuADBOEDF4phs9EQzfQbJ17rL1Ey4auxemH
         hwDg==
X-Received: by 10.68.240.67 with SMTP id vy3mr10315278pbc.119.1361665515051;
        Sat, 23 Feb 2013 16:25:15 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id rn14sm7422636pbb.33.2013.02.23.16.25.12
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:25:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361665254-42866-2-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216955>

David Aguilar wrote:

> mergetool, bisect, and other commands that use
> git-sh-setup print a usage string that is inconsistent
> with the rest of Git when they are invoked as "git $cmd -h".
>
> The compiled builtins use the lowercase "usage:" string
> but these commands say "Usage:".  Adjust the shell library
> to make these consistent.

Scripts could be grepping for Usage:, but they are asking for
trouble and if anything should check for status 129 instead.
And luckily we have been careful about not checking for this
in tests.  Thanks for the fix.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
