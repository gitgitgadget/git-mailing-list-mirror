From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git build failure with libssl (OpenSSL) in custom directory
Date: Thu, 18 Nov 2010 11:49:21 -0600
Message-ID: <20101118174921.GD16610@burratino>
References: <AANLkTikQC9hncPZkeScWi7OsWw+Optbvxaygyn1p7_sN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lars Buitinck <larsmans@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:50:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8ci-0006tA-1w
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759993Ab0KRRuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 12:50:08 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44964 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab0KRRuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:50:06 -0500
Received: by bwz15 with SMTP id 15so3012917bwz.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 09:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=la555VRXXndxwvy0uGV+y6bwX3zpr609tE+SGwuWEXU=;
        b=YJyN36dsdsKHY/9yDLdmzrfIgZo2X4nOAMqHbtTMY5CHtQO9Cj7A/27sjZVnfCTfr/
         BGrBnsxQ4XHelb9wf1vtAZUtfdh7D+VOnTJz+wjZfJ0vyKrmP3pYxSkYP4cRZ+vTB3GT
         9c1cZkUmY7n3PMrDY5ceyqc1VkqaizcYELPRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kq8PhURyl2/8H4/bZI/cb7ZqwmcPgP3dVL3hdTd/2aldnQ1J3QGm5bePcgCYwaZFAd
         O0dZoVBJAkiFwNl0fm0JW/Lz/aNZgdj5bEyHRQ9rJ6GyQxnEwf6r2NLSCe0FThFm21Lz
         AImsSKleC9KzwMo6MLe96AWiptL9TdXTyTx0Y=
Received: by 10.204.79.9 with SMTP id n9mr895208bkk.126.1290102604739;
        Thu, 18 Nov 2010 09:50:04 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a24sm719175fak.3.2010.11.18.09.50.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 09:50:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikQC9hncPZkeScWi7OsWw+Optbvxaygyn1p7_sN@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161694>

Hi Lars,

Lars Buitinck wrote:

> =C2=A0 CPPFLAGS=3D-I$HOME/apps/include LDFLAGS=3D-L$HOME/apps/lib mak=
e
> prefix=3D$HOME/apps all doc info

How about

	prefix=3D$HOME/apps
	make CPPFLAGS=3D-I$prefix/include LDFLAGS=3D-L$prefix/lib prefix=3D$pr=
efix \
		all doc info

?
