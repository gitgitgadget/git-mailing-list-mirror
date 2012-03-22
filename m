From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 10/9 v4] difftool: fix regression in '--prompt' options
Date: Thu, 22 Mar 2012 09:51:14 -0400
Message-ID: <CAFouetjqzAwCe3mHkpJB4Xod4rJEF9OD77ch906TGUd9+-KZWA@mail.gmail.com>
References: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
	<1332381236-16004-1-git-send-email-tim.henigan@gmail.com>
	<7viphxz37j.fsf@alter.siamese.dyndns.org>
	<871uoljbe9.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	davvid@gmail.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 22 14:51:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAiQD-0000PX-Hi
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 14:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108Ab2CVNvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 09:51:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38201 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab2CVNvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 09:51:15 -0400
Received: by iagz16 with SMTP id z16so3141611iag.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ClhCqaG5vZB5vk5ucp8RGmJHPI8PKydGQXE+dj/lFIA=;
        b=eFXwSFVTOQ9FHBXXkWdK33cgJ2THvM6LGOpgnn4m6zIW3btVHg8chRJNaHtDv5hdWK
         gv5jPeOXVivA89Bu/U4k+cPoxnhwZBHvRjINkxpzCA6ha2cUs0FgQ7hC/bCSloWjDB8G
         WMrrJKjD0BVBy1w12ygDLLLpvEcb9GC55onEOBoasO2NWvxL0uLB4XlXr10Mn0SnlNcd
         YhslvW7gfGloKZZ69YPghwAoUBTrBIRl/9/weSJcc9VfZ61zvObUCzZstXo+4OXtL/pz
         Vgpf4yt3H4WbnncCZWvID3rjgzKmPn4x1FnlO7yVfgTmVy5SuqjwYBB2uEN4m8WD+2+U
         DOkQ==
Received: by 10.50.188.138 with SMTP id ga10mr1688186igc.51.1332424274830;
 Thu, 22 Mar 2012 06:51:14 -0700 (PDT)
Received: by 10.42.138.5 with HTTP; Thu, 22 Mar 2012 06:51:14 -0700 (PDT)
In-Reply-To: <871uoljbe9.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193656>

On Thu, Mar 22, 2012 at 4:19 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Tim Henigan <tim.henigan@gmail.com> writes:
>>
>> I really do not like the direction in which this series is going. =C2=
=A0We do
>> not have a similar --no-gui option to defeat --gui option that may a=
ppear
>> earlier on the command line, but when we fix that bug (isn't it a bu=
g?),
>> we would have to teach this loop about that option, wouldn't we?

Of course, Thomas is correct and the limitation was with my use of
Getopt::Long rather than the module itself.

v5 of the patch will use Getopt to parse the '--[no-]prompt' options
again.  I will also add a new patch to the series to implement
'--no-gui'.


> Limitations? =C2=A0You can basically steal code from git-send-email. =
=C2=A0As an
> example:

Thank you for the example...I should have found this when I read the
documentation earlier.
