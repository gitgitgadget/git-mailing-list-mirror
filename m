From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 2/3] git-svn: Make it scream by minimizing temp files
Date: Tue, 12 Aug 2008 11:50:22 -0400
Message-ID: <48A1B13E.2050603@griep.us>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <1218470035-13864-3-git-send-email-marcus@griep.us> <20080812031442.GB14051@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 17:51:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSw9k-0008Mc-8S
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 17:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbYHLPu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 11:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbYHLPu3
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 11:50:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:17903 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbYHLPu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 11:50:28 -0400
Received: by qw-out-2122.google.com with SMTP id 3so218866qwe.37
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=h1HA3t5el6CcGa2YpFhh0g/zrNZwthuoRN2RCIRQs8Y=;
        b=wynRg8G8jbawHo08hxL2boTET/m6LyV2RNwigX+/fe24Lb4mjJyQThhKBloCc5PP1P
         JEmwIu9E6miapek0vHcD/san9VL+rUOCTpQn55PHhZCRjgF43PPopK4Vn/JV8oh5qsgn
         4J9aVO79ArxSJvLT0oxeW5Md7dP7JFoCBizZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=Hp3lDSLbTjU9pQQVUJkxM2PFftn4tbmKNh5mzMH98JJfhurz314JtkLzGyju1vHpt3
         WSKmG5QLoBuaL6EnbzhISU0JIYmuIKXPjcpiV7mbczRB2cBykC0ZYC1u8QQTZWfz7ynO
         IZUg6fhDFT9YRPIpVBQCNHvnvg96SqUYMegjo=
Received: by 10.214.216.2 with SMTP id o2mr6600946qag.54.1218556227357;
        Tue, 12 Aug 2008 08:50:27 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 3sm3073172wrs.22.2008.08.12.08.50.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Aug 2008 08:50:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080812031442.GB14051@untitled>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92104>

Eric Wong wrote:
> The above is dead code now that we're using the versions in Git::,
> right?
>=20
> Why create a temporary variable? (and break the sacred 80-column limi=
t).

My cherry-picking & squashing skills are not yet up to snuff.  The dead
code and unnecessary variable have now been removed.

 > I missed this before, but $tmp_fh->filename doesn't interpolate corr=
ectly.
>=20
> ("write ${\$tmp_fh->filename}: $!\n")
> or
> ("write ", $tmp_fh->filename, ": $!\n") works.
>=20
> I believe the latter form is more idiomatic so we should probably use
> that...

Done, in the latter form, and fixed in a couple other places.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
