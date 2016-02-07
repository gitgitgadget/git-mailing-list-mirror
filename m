From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 00/11] Fix icase grep on non-ascii
Date: Sun, 7 Feb 2016 03:48:47 -0500
Message-ID: <CAPig+cSU9g28a7tnXJvoGJ4MkmnuWmcsy+vGUiY6L8+9v6iusg@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 09:48:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSL1Y-00062B-PP
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 09:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbcBGIst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2016 03:48:49 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36151 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcBGIss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 03:48:48 -0500
Received: by mail-vk0-f65.google.com with SMTP id k196so753068vka.3
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 00:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=eOQI3n6BdYdBwD+GcOKpwi/E5dpWgBvU6gpZ9kuVD5I=;
        b=ATGrqXn+jvb4a7R+EuZkww0v1g4AFKtrs4pNPC2CY318P8ZSJM+7xw7zg9s/WqRSyE
         vxprgGnCfjkMa2jK+u7jcOhiYxuMi5RufUaENyxz8kj8chBxsdFhIL+Sjpt5/Iv+kExm
         Vznz97DWku7cH42j+AVieCQOa/T4dHFnH8O4lx+EqvCKDrK1Nqr5rLco38ptdM4A21cV
         KjKn89zhdXklmWXMimHdGqY6E1CwC7eTfvFs4t/WdUvgw9jtZaKC42nxLjWD/I/Wz6FP
         UsQu7U9upDoIRDGl/nCWcpoKPx5d900AqIrJtMJhA7SNJjJ929ZqWAZRxI9f0gFLGG0a
         DifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eOQI3n6BdYdBwD+GcOKpwi/E5dpWgBvU6gpZ9kuVD5I=;
        b=HerdP7GfcZTIOpkRYXY+dup7NOnFTs7gmhd+DSEHNPdt8YYM5tWuTOlB3AznnwHay5
         /cvieu3++zfx+PnBAa/8eSNsBnedDwh4RykCtF7GTkfWo5BLHMDNORE38ygIr9gAIyvS
         dm+FU0r6UaEuVDvfe/cMnV6bi3Wx6hBXteMJZ/ZxxPls7nbC7DcuzX2OHsXOIipXM6ji
         FBZDVjgID0b9mhFbRhkfEw8Aa9uHmzO7Bs01SppO865EmzauG0M/9tmpZ/0lkfWVUW1N
         bIXozFCxv+R4W8mY4cVN/ZaN1lfwVYPLBUGm/sgzxvQvEkdIk4cEuLaE9hZ6fFOE58t4
         a5iw==
X-Gm-Message-State: AG10YOQttWjcWYig9spSoNgClflvns7rSGAJIOeAJIgfaAOcWkmvgz/Oaf//w+sRiofpB6DDQ/k83gqsQAY0Wg==
X-Received: by 10.31.146.71 with SMTP id u68mr13723518vkd.19.1454834927701;
 Sun, 07 Feb 2016 00:48:47 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 7 Feb 2016 00:48:47 -0800 (PST)
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Xst6d3rROusJpKJ_r6XC-GwQDWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285719>

On Fri, Feb 5, 2016 at 9:02 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> v6 fixes comments from Ramsay and Eric. Interdiff below. The only
> thing to add is, I decided not to replace !icase_non_ascii with
> icase_ascii_only. I went with spelling out "!icase || ascii_only". I
> think it expresses the intention better.

v6 appears to address all the comments raised in my v5 review. Thanks.
