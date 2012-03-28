From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 9/9 v8] difftool: print list of valid tools with '--tool-help'
Date: Wed, 28 Mar 2012 16:16:46 -0400
Message-ID: <CAFouetiCmmEZDN0ATYE8fQ=CFzA-F+DEWoe-uSNL6Hu_8__rJQ@mail.gmail.com>
References: <1332959684-2231-1-git-send-email-tim.henigan@gmail.com>
	<7vvclov9hi.fsf@alter.siamese.dyndns.org>
	<CAFouetjbq+A04HECXN39KeLBgkTd+HJyxeM0wSDhS2Xo=_gQVQ@mail.gmail.com>
	<7v4nt8v6ip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:16:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzIb-0004X9-1W
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758457Ab2C1UQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 16:16:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60404 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397Ab2C1UQr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 16:16:47 -0400
Received: by yhmm54 with SMTP id m54so1048744yhm.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2gniVH5/TQ3vksPWsoeCs2X49NiwBPEJ1SeQbMfeyyE=;
        b=QJ+JMYAWajmCXgCOIlPhfZrNZPRJmrN7CrDnQdjSmcPNHDXDBCyzgzycWa0YZfaTyI
         n6mPURHFa20aLG3kdf4Bb/GX5bn4qi3KjlrIFEXvRuZx+7RGs0ypBoYwIbglVu1xzzhM
         yNNhnPOqbjjdKaQukEuUWDfOVtGiEPxyWXhLMPmyqjZt1yHC9TGeexJVFs6o8HDNIpH6
         kAgneFScQoVkPq8JN/wmPR9MiniPSt+NctH7+3Pp/vcvi4+iPeA3vz4dv9+4SG245gM4
         dNq5n1YtnaSPiaEdvCmcKG/upoYgtWCpMtsC1bJWDSrcQldoUA8W5k45QlV+91h8Jv4G
         nejA==
Received: by 10.50.42.132 with SMTP id o4mr349411igl.41.1332965806713; Wed, 28
 Mar 2012 13:16:46 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Wed, 28 Mar 2012 13:16:46 -0700 (PDT)
In-Reply-To: <7v4nt8v6ip.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194183>

On Wed, Mar 28, 2012 at 4:02 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> That is even worse, no? =C2=A0Is the rest of the code prepared to giv=
e you "git
> difftool -t baz" in such a layout? =C2=A0What if you have another baz=
 next to
> foo and bar?
>
> What I was hinting at was that you may want to $File::Find::prune=3D1=
 when
> you find a subdirectory. =C2=A0While at it, you may also want to repl=
ace
> the "unless -d $_" with "if -f $_ && -x _" or something.

I see now...sorry I missed your obvious point.  I will look into this f=
urther.

The script makes some assumptions right now:
  1) All tool config scripts must be located in "$(git --exec-path)/mer=
getools".
  2) There is only one tool config in each script
        - See my other other recent patch that splits vim/gvim [1]
  3) The name of the tool script matches the name of the tool itself.

Do these assumptions seem reasonable? If so, perhaps I should add a
README to the mergetools directory that outlines these assumptions?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/194179
