From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCH] Locate git helpers with type -P, for when git --exec-path
 is multivalued
Date: Thu, 22 Mar 2012 11:24:54 +0100
Message-ID: <CAJh6GrH9NAQ5=zHE-nrCj3b1NvJUaaenNzTmvon5Ut2XaS1dsg@mail.gmail.com>
References: <1332407219-7774-1-git-send-email-domq@google.com> <87pqc5ged3.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 22 11:25:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAfCs-0006DT-Ou
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 11:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab2CVKZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 06:25:17 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44468 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab2CVKZQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 06:25:16 -0400
Received: by wgbdr13 with SMTP id dr13so1270212wgb.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-system-of-record:content-type:content-transfer-encoding;
        bh=orosWUuV3X9/U+0/3hkifMrPXaG4vOeCCGuFdNmJGSM=;
        b=XaZBNqRQH7Qj8c9fHwWuNhAvdxiwi/3KS+Coio8w3MbGb7uHT2m+gWNJdc0S3xleFA
         RjxqCeM+Ej1GnSoOoCDsa+hjhuYU89r/iAzTlfxZI8MuyXeZxtwcvsjpLBdfVi67rGrb
         Y/O84BOPkmO5KxTUXLREHEw6gveTKRbw7xyZ7xQX47KMxZfmPpehwv3kDTpbQQ0rbzrB
         fp+L5DZHalN/L6lc9jqXgXkaENxRRETUxpMNbJ3XKSqt1xPSkCzBsUVwgvvte+g8Vnom
         9iJMrVIu5nlunbWWxuXQQ9slguaK+4PvBWOuQ6HN5hfFQ6Sa0nmskZrzRev3LAcQwZuO
         6YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-system-of-record:x-gm-message-state:content-type
         :content-transfer-encoding;
        bh=orosWUuV3X9/U+0/3hkifMrPXaG4vOeCCGuFdNmJGSM=;
        b=nS07pQEGJhwRmbeXhVgtCtFVJwcl9Pb9ZYNLvhyPcURiwmtQyZiA8BLBdGzIfqxAPH
         gmr5Ii9FkFLpWO6k7GsfY3GmaRALA/AZ/uAUiyWNTsVAJRTVPUeLXM0UPFddivMCh2Zg
         NdO+jtjgBQpWLxgIgalFBY46c6HsseTHoKWsF6GU7ZlT9ixxyt9kGNdoQ8o1j+2FuGAr
         PqV1+SIPoukJviuhkDZI4tpFZahJbUgSILqBMliUDlZMiMR7XL0SsV16FP7eR+2Xei2/
         ZZ5SS0uW30oFKUKB4QjP5Ap5Y8s+dnr2nyOxi0GXyZl8s21ZXe/x29jfDEEJtOKyoVZi
         Tbjw==
Received: by 10.180.72.212 with SMTP id f20mr3659752wiv.15.1332411915085;
        Thu, 22 Mar 2012 03:25:15 -0700 (PDT)
Received: by 10.180.72.212 with SMTP id f20mr3659739wiv.15.1332411915016; Thu,
 22 Mar 2012 03:25:15 -0700 (PDT)
Received: by 10.227.24.144 with HTTP; Thu, 22 Mar 2012 03:24:54 -0700 (PDT)
In-Reply-To: <87pqc5ged3.fsf@thomas.inf.ethz.ch>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQlvE+PmSqUfG3lVLNYGT5DtzHoSioXZaNiHbpWlZopsWPcgPd4bV+2yUTc/GzrZvYaMpi1AurQCxiJ4NSGG1ZjyYt7amtM+fVhS2BgXa0Dmi841GSvyZM5t8spAG8acD4HMDH7ye/ghxcfukFrLaMKXIkiROw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193641>

On Thu, Mar 22, 2012 at 10:43 AM, Thomas Rast <trast@student.ethz.ch> w=
rote:
> I don't know where you are getting your
> multivalued GIT_EXEC_PATH from,

Well it used to work for me before, apparently not by design... Too bad=
=2E

--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
