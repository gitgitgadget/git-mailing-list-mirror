From: Lars Buitinck <larsmans@gmail.com>
Subject: Re: git build failure with libssl (OpenSSL) in custom directory
Date: Thu, 18 Nov 2010 19:04:00 +0100
Message-ID: <AANLkTikZBcmbFoCmqT-eorGm3R0YYjkzotc414w_PHyd@mail.gmail.com>
References: <AANLkTikQC9hncPZkeScWi7OsWw+Optbvxaygyn1p7_sN@mail.gmail.com>
	<20101118174921.GD16610@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 19:04:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8q9-0000FZ-CM
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 19:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760029Ab0KRSED convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 13:04:03 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52282 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab0KRSEC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Nov 2010 13:04:02 -0500
Received: by fxm10 with SMTP id 10so173855fxm.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 10:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VuXI+w0GzruZjoh6oz/zUPIZtH5jkfQGSexjH2cRAog=;
        b=mvX4LYQmBWHXGh13N4aVYWEJ9K5ORkE1PwkVZcnrllsN2gr4JYsC0g+YH8lzZ1TCLq
         Q4lW1F6rZYrH73RWIsiVCDm+JmxEEFxlWhfpNg/4MHNzqETn/XrKhaN1Ksa91kBdb80Y
         KVBeNG7YMz1XLYBgB4EqvJa8k2HzVWk/EQ5Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rtVba4uK6aZaoH5k+iixEtGu5qpH9iLph7V2s+JBF0+TTqpf6M4HVKxsc6EWjXnMSn
         d5p62YIfFASuiD1HFVBZRiE9p/WhTT3KgsmUrbmEoEblBDNEh/cWl17KO5mfr8y9tuyK
         Hdapq+Hf/TDOoo9sjt/9HVGNJK5DjRP/tayaw=
Received: by 10.223.73.207 with SMTP id r15mr851128faj.141.1290103440518; Thu,
 18 Nov 2010 10:04:00 -0800 (PST)
Received: by 10.223.101.132 with HTTP; Thu, 18 Nov 2010 10:04:00 -0800 (PST)
In-Reply-To: <20101118174921.GD16610@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161698>

Yes, that works fine with LDFLAGS=3D in the Makefile. Is this just a
lack of Makefile-fu on my part?

2010/11/18 Jonathan Nieder <jrnieder@gmail.com>:
> Hi Lars,
>
> Lars Buitinck wrote:
>
>> =C2=A0 CPPFLAGS=3D-I$HOME/apps/include LDFLAGS=3D-L$HOME/apps/lib ma=
ke
>> prefix=3D$HOME/apps all doc info
>
> How about
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0prefix=3D$HOME/apps
> =C2=A0 =C2=A0 =C2=A0 =C2=A0make CPPFLAGS=3D-I$prefix/include LDFLAGS=3D=
-L$prefix/lib prefix=3D$prefix \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all doc info
>
> ?
>
