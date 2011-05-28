From: =?UTF-8?B?RnLDqWTDqXJpYyBEZWxhbm95?= <frederic.delanoy@gmail.com>
Subject: Using really empty start prefixes for git-format-patch numbered patches?
Date: Sat, 28 May 2011 23:57:01 +0200
Message-ID: <BANLkTikVQWN2kZ4gc8kd-kJWZhLXgkvTAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 00:00:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQRYc-00013c-BV
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 00:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab1E1V5d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2011 17:57:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38189 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab1E1V5c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2011 17:57:32 -0400
Received: by ewy4 with SMTP id 4so983923ewy.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 14:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=NRFirTaiWZzv94aXailj5gL1YiLdy4DoyOzIFx3uTkI=;
        b=IuX0rLt2psbITA6/CdzIoPzeDGzIawFOvofN3VlYhNBQyWiFEcvqSP6TpE94/sQJc8
         wZU400xjQi39Mb7J4hY3EjnyMiikOfLzb07plznMGZzzquxUUHp7vsEjF15KErRWRUaK
         A7MbLHjeKbxgO5I0AYiwHUT+x/DyqJaXhFo60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=GjmCy11nP29TbX9lRhh8vULyZQl8IIA6BOsGWBohOz2fzYkYUHhzjxSmF6gvIZJpfP
         HzC0P/oCh5Zx1p3fs3HQaHAhTXMK17TPn3vtSmfRWFQD46P3Q6/u9RPypp5iQ3vnEilb
         wif2bBHZNn5JX8vheBGvN9KsXYPOJx0uEUwAM=
Received: by 10.14.53.136 with SMTP id g8mr1282261eec.239.1306619851237; Sat,
 28 May 2011 14:57:31 -0700 (PDT)
Received: by 10.14.100.16 with HTTP; Sat, 28 May 2011 14:57:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174681>

Hi,

I'm trying to generate numbered patches using git-format-patch such
that I get e.g. [1/2] instead of [PATCH 1/2]

However, if I use an empty string as prefix, for instance in

git-format-patch --subject-prefix=3D"" -2

an extraneous space is inserted, and I get [ 1/2] instead of desired
[1/2] in the Subject line

(I also tried using a single backspace char as prefix, but that didn't
change anything, as might have been expected)

Is there a way to get rid of this space? IMO the space should only be
added if the prefix is non-empty

=46r=C3=A9d=C3=A9ric Delanoy
