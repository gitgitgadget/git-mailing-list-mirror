From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Wed, 20 Mar 2013 11:02:50 -0700
Message-ID: <7v1ubaeyph.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:03:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINMA-00023G-1l
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606Ab3CTSCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 14:02:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755469Ab3CTSCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Mar 2013 14:02:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09967A29E;
	Wed, 20 Mar 2013 14:02:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FZMPN7MoUnmE
	e0+vEIGufmSbqd4=; b=gl9IMbivld9utxKDZ9a9PWiblLjkXDF5/ljU40fygE0E
	wyqyRfuwP7ojXIAS7+PZ0qZn5PnBzZJHud7gVLhY7SG4qLJrGcwWRpHOrdVB0VFr
	RGN29/GlR4aV9fXm7ANqPWBGE9wvTmrKOI4cNUiiA94rF7zVsMJF4jUbfl12S4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XbagVl
	1ZXY346doHAzqdBtV9HC4fzMbqNoQJc5lMnJJtqcKz1ZkJTOhmNKLZRvaNf+66Mk
	dox9zyvDwU2QtIl8QaLm7nlSpvSwCWjDMi3q2PXgjU21CofkWNODRqgKLA61h/ac
	d2F9FC+0gmYZ2AEHfWLvh1TK2NydYo+OZKEnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F27D4A29D;
	Wed, 20 Mar 2013 14:02:52 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D9DEA299; Wed, 20 Mar 2013
 14:02:52 -0400 (EDT)
In-Reply-To: <1363781779-14947-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20 Mar
 2013 19:16:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62374B2C-9188-11E2-AEAE-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218632>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Junio please pull the series from github [1]....
> [1] https://github.com/pclouds/git/commits/parse-pathspec

Please write it like this:

    https://github.com/pclouds/git parse-pathspec

so that I can just say

	git fetch <<that thing>>
        git diff nd/magic-pathspecs FETCH_HEAD

I am still getting this out of 7300, though.

expecting success:=20

        mkdir -p build docs &&
        touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
        would_clean=3D$(
                cd docs &&
                git clean -n "$(pwd)/../src" |
                sed -n -e "s|^Would remove ||p"
        ) &&
        test "$would_clean" =3D ../src/part3.c || {
                echo "OOps <$would_clean>"
                false
        }

OOps <>
not ok 8 - git clean with absolute path
#
#
#               mkdir -p build docs &&
#               touch a.out src/part3.c docs/manual.txt obj.o build/lib=
=2Eso &&
#               would_clean=3D$(
#                       cd docs &&
#                       git clean -n "$(pwd)/../src" |
#                       sed -n -e "s|^Would remove ||p"
#               ) &&
#               test "$would_clean" =3D ../src/part3.c || {
#                       echo "OOps <$would_clean>"
#                       false
#               }
#
