From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5] git-p4: add config git-p4.pathEncoding
Date: Wed, 2 Sep 2015 22:32:10 +0100
Message-ID: <CAE5ih7_Kje_Qrz7zKH4uSGziVpdp6VqsZf7hSMwQkvta97CG9w@mail.gmail.com>
References: <1441226355-61103-1-git-send-email-larsxschneider@gmail.com>
	<1441226355-61103-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 23:32:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXFdf-0001yC-8R
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 23:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbbIBVcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2015 17:32:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34339 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbbIBVcL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2015 17:32:11 -0400
Received: by obcts10 with SMTP id ts10so19869442obc.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sMS9dE8z3Iqp6B+CLedCDDMnVepvdwyg3aqSxawqWgU=;
        b=iLoHcVC5IA8AupZfRJelYS4zkWYNgGf6EcA3654t/bMAwabtw0tkMakVPggLc342RJ
         kX8eUw7dDXTS5iEKioCNg3RBJVfFI4at6SPvFtw8f6sTEXV784SbspNF1uxq0S9WNQdb
         2NPocLtgnsGotf8PObxM5f2nY50TEjWHU7rok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sMS9dE8z3Iqp6B+CLedCDDMnVepvdwyg3aqSxawqWgU=;
        b=b6oPmMLEkwAACEu3Y+zKXmcXSIfIqXgbwl7dbV1SisWvSXLejqxgbMaOr48V/P42zp
         DzVC2MYLfUN6D4uNKpxQ/oA/L1UM01ydknfSbc77JsPpyKOBZ2TueoKQXwM/x+lX7vyU
         fLVSuPpNdR98jCxgJ4N3NzkKK6q3Qd7L1hlPs2aVuVJ0WMtlE+9CdAF7XcGOgdOHzqmM
         I97w2KH6SGW6w7Mai5RdAEf6T4aocpq3343q4JSpM7SI2O/ABs+edNOMF/NN7D1otf/8
         8wXWQxveyod3mzzvxptDtcDfQNzcLjDpvNQH9gXhKGU+X33vAj9uFOqlpm8q8xkH7ehp
         43mQ==
X-Gm-Message-State: ALoCoQl3AhZ1tNTn1R7vCFXwntiTO00W9bqI5RpQYcoXyIscHYmSSTPFzOQM016aWHj7djL1dutI
X-Received: by 10.182.39.194 with SMTP id r2mr24369283obk.20.1441229530529;
 Wed, 02 Sep 2015 14:32:10 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Wed, 2 Sep 2015 14:32:10 -0700 (PDT)
In-Reply-To: <1441226355-61103-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277127>

On 2 September 2015 at 21:39,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Perforce keeps the encoding of a path as given by the originating OS.
> Git expects paths encoded as UTF-8. Add a config to tell git-p4 what
> encoding Perforce had used for the paths. This encoding is used to
> transcode the paths to UTF-8. As an example, Perforce on Windows ofte=
n
> uses =E2=80=9Ccp1252=E2=80=9D to encode path names.

Looks good to me, and the test passes.

Note that git diff --check complains about a trailing whitespace.
