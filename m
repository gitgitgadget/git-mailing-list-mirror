From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] contrib/test-hg*.sh: Do not use PYTHON_PATH
Date: Wed, 17 Apr 2013 08:53:26 -0700
Message-ID: <20130417155326.GB3499@elie.Belkin>
References: <201304171610.49384.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 17 17:53:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USUfw-0007SC-DN
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 17:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966773Ab3DQPxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 11:53:32 -0400
Received: from mail-da0-f47.google.com ([209.85.210.47]:39747 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964900Ab3DQPxb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 11:53:31 -0400
Received: by mail-da0-f47.google.com with SMTP id s35so843892dak.6
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EnxdlQfHPEF6CyYalS7/ghDKmExi6U2No4teXbOGOYk=;
        b=U42im1q4ghDwiRkg7a+LSIoniYnE/QBDEtU192vt+imlNw1AvbAqsvzp6tJtU7TtG7
         ogMOi3kr+YEYWLeUXJn+u5DXB6KhBEbltDBIVUDZ3ab20V1RWt6CpgZZOoj2rJlAZt+/
         B4xB5EPeInzXMplXKBS449zoAbd40jA8CHvai1QxPt2KyvbgHuNmsjEbRty+nnrOBWa2
         xC7K7c/RPnC8GNH13jd/F23P8E+CWyeovGxC/U5n4wNacErI3vHUvcC/xrci911XeXbh
         yUc1y45+iJEq+ooXfbS+5ANO6iED/8/c5mgswAUBFqGEEzW7X4xM61jvbnL++iuWjS0R
         4dOg==
X-Received: by 10.66.148.132 with SMTP id ts4mr9742283pab.19.1366214011141;
        Wed, 17 Apr 2013 08:53:31 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id g8sm7582821pae.7.2013.04.17.08.53.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 08:53:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201304171610.49384.tboegi@web.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221549>

Hi,

Torsten B=C3=B6gershausen wrote:

> Git respects PYTHON_PATH, hg does not.

Probably more relevant is that contrib/remote-helpers/git-remote-hg
has a shebang line of "#!/usr/bin/env python" and hence does not
respect PYTHON_PATH.

> Use python instead of $PYTHON_PATH to check for installed modules.

Makes sense to me.

> While at it, split exportX=3DY into 2 lines

Would you mind splitting this change (which also looks good) into a
separate patch?  It makes life debugging, cherry-picking, reading,
reverting when needed, and so on easier.

Hope that helps,
Jonathan
