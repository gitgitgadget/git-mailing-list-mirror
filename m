From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/14] appp.sh: use the $( ... ) construct for command substitution
Date: Mon, 28 Apr 2014 10:53:18 -0700
Message-ID: <xmqq61lts5m9.fsf@gitster.dls.corp.google.com>
References: <1398260646-2660-1-git-send-email-gitter.spiros@gmail.com>
	<1398260646-2660-4-git-send-email-gitter.spiros@gmail.com>
	<20140425225843.GA238861@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:12:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weqy3-00085L-3p
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbaD1TKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:10:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbaD1TKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:10:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B30107EF2B;
	Mon, 28 Apr 2014 13:53:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7XqPqTUD8BcR6VV5MNE7OKSKkNU=; b=VZu7rI
	4SUl7oHdWKkYMjG2XgnX59bow9btzYmeoEGzTOyTO7LSx6EtTcnjiJAm4lvqDU5e
	pOT/IInsEB4DVQawRsSNlT+8LUWbE1rxpJK3OC1+TV0oBbs8RwfhQ/LN6qFdm7kd
	TmGx7OS66tRq1pVJIyw/B5pa8JJpltwtLAsLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xASpsKKp8zL0X6JUXM9ZplMbUSnVy7jX
	s8sWWrRKnHFm0MDMWNAlNbEsCPpjB7cLdp0W8whQXhWBw1ZONr0BVtwBhSgbzLgT
	x+ZQykKzeyIipUFnIN4JdtfMp6jhE6OF/drBA5p7iwa3c+viPmIMm9eDesXp7Kuy
	w7dFPXCKjvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9109D7EF2A;
	Mon, 28 Apr 2014 13:53:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 697D27EF26;
	Mon, 28 Apr 2014 13:53:20 -0400 (EDT)
In-Reply-To: <20140425225843.GA238861@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 25 Apr 2014 22:58:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FC3A6EC6-CEFD-11E3-9BC9-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247388>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>  CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
>>  	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
>
> It looks like you may have missed a usage here due to the line break.

Good eyes ;-)

The following may be an obvious replacement patch, but alternatively
we could just drop the whole thing (contrib/ material is not
something we would need to police strictly for the style---nobody
should be mimicking their styles as they are not part of _our_
codebase in the first place).

 contrib/thunderbird-patch-inline/appp.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index 5eb4a51..1053872 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -10,7 +10,7 @@ CONFFILE=~/.appprc
 
 SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
 if [ -e "$CONFFILE" ] ; then
-	LAST_DIR=`grep -m 1 "^LAST_DIR=" "${CONFFILE}"|sed -e 's/^LAST_DIR=//'`
+	LAST_DIR=$(grep -m 1 "^LAST_DIR=" "${CONFFILE}"|sed -e 's/^LAST_DIR=//')
 	cd "${LAST_DIR}"
 else
 	cd > /dev/null
@@ -25,14 +25,14 @@ fi
 
 cd - > /dev/null
 
-SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
-HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
-BODY=`sed -e "1,/${SEP}/d" $1`
-CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
-DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
+SUBJECT=$(sed -n -e '/^Subject: /p' "${PATCH}")
+HEADERS=$(sed -e '/^'"${SEP}"'$/,$d' $1)
+BODY=$(sed -e "1,/${SEP}/d" $1)
+CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
+DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
 
-CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
-	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
+CCS=$(echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
+	-e 's/^Signed-off-by: \(.*\)/\1,/gp')
 
 echo "$SUBJECT" > $1
 echo "Cc: $CCS" >> $1
@@ -48,7 +48,7 @@ if [ "x${BODY}x" != "xx" ] ; then
 fi
 echo "$DIFF" >> $1
 
-LAST_DIR=`dirname "${PATCH}"`
+LAST_DIR=$(dirname "${PATCH}")
 
 grep -v "^LAST_DIR=" "${CONFFILE}" > "${CONFFILE}_"
 echo "LAST_DIR=${LAST_DIR}" >> "${CONFFILE}_"
