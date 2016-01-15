From: Robert Labrie <robert.labrie@gmail.com>
Subject: SChannel support in Git for Windows
Date: Fri, 15 Jan 2016 10:04:17 -0500
Message-ID: <CA+1xWaokgVthDv-up76RP+s+r4pSv5ntmePtDVND+rsKuo+-YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 16:04:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK5vP-0002qp-KD
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 16:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbcAOPEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 10:04:21 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36111 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbcAOPES (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 10:04:18 -0500
Received: by mail-yk0-f173.google.com with SMTP id v14so451825263ykd.3
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 07:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ogPEd8fItcSCuE6C16HhK/atH4jsdQI6f4fhA60Y1Yw=;
        b=lvo5Ynbt8TSAMOLPa7SSPCiYjRXPOjhsMmHjnCkKndCRUyivISeu09IHkgd0OLJNct
         2tolvZDU6uK6maA6H+RqEUq5QG5clIc83jO5TpVyY344j8WTyA4UYaHKtns3WvOAt1GV
         Mpyvsm+6VIe9Cb0hQTUeGnK/BDZouv1clQpp2WjuLhhgylkz3wgekuMJLDT3h/Srt0I2
         OOfCRCc2b/oNN3DwhN7f5zjJhZrIQbw7lgi8++wrdfIGML8FakCDEC8iZQbP+VqveaPl
         Y+zOrHKlLFtE8XK/4IbKkGG0jnke0fptc5BBL93B9QeKg9b0H5vdxQ7x/RF/XsaBUDBI
         NknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ogPEd8fItcSCuE6C16HhK/atH4jsdQI6f4fhA60Y1Yw=;
        b=G0nKNDbfxlPzto8QMmaPHm+HryOWfYxZkvVQl+jaigw1OTxkeT8fNqb66hSmTLllgJ
         Qi2p4TSvMaDoz7uykEAue3l+4i0VeP4lfLXgATDb8/N4YPZk2QEv1T4bPs+7NHIZ6cr7
         IsU8U14s+xot7Z8C1jMX+9XhqFPtHfFKWtTpjUeMzLWI7ud2yKxvbtEgFRIByqaBv/ps
         7dJxEWEJyOIKOHeaSWpZlrp0SbnwlI/zQ7IKZOO86zZs5CuTSt6IWWwWx1B/O51n61+9
         f3bpPzxcfUkD41RBYooKBjDKyDKoZov7vKe4Give32OUE3c2i+wjh7NQSLWAjOJCClI1
         k9bA==
X-Gm-Message-State: ALoCoQmXZho/1CfWQLmsi1qsQpWrCQhIBhgHdLdUeel/5fvZR6yEgXzabyaFXr0Vm2KKaVZZBGLbVtSfFBkzucIqMHVR99pZvw==
X-Received: by 10.13.241.199 with SMTP id a190mr8263023ywf.47.1452870257747;
 Fri, 15 Jan 2016 07:04:17 -0800 (PST)
Received: by 10.13.216.10 with HTTP; Fri, 15 Jan 2016 07:04:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284173>

I googled for this and couldn't find anything, as best as I can tell,
it's not a thing.

Increasingly, network admins (including mine) think it's appropriate
to intercept TLS handshakes on the firewall, and present the calling
application with a self-signed cert for the requested domain (ie
github.com). On Linux, this can be sorted out by putting the internal
issuing CAs root cert in /etc/certs (or somesuch) and on windows, by
importing it into the "Trusted Publishers" certificate store. The
challenge comes from apps using OpenSSL on Windows, which doesn't have
/etc and doesn't support the windows certificate store.

Presently, I'm using this procedure:
http://stackoverflow.com/questions/9072376/configure-git-to-accept-a-particular-self-signed-server-certificate-for-a-partic

But it would be more awesome if git just supported schannel on
Windows. I think cURL does already.

Sorry in advance if I didn't Google hard enough for this.

Thanks,
Rob
