From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document disabling core.whitespace values trailing-space
 and space-before-tab
Date: Fri, 25 Jul 2008 01:49:43 -0700
Message-ID: <7v3alyuz4o.fsf@gitster.siamese.dyndns.org>
References: <4888144E.8090300@sneakemail.com>
 <20080724172912.6117@nanako3.lavabit.com>
 <7vbq0m608w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 10:50:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMJ0o-000380-OZ
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 10:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbYGYItz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 04:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbYGYIty
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 04:49:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbYGYItx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2008 04:49:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52967385E2;
	Fri, 25 Jul 2008 04:49:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A167D385E1; Fri, 25 Jul 2008 04:49:48 -0400 (EDT)
In-Reply-To: <7vbq0m608w.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 24 Jul 2008 21:44:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A58543B4-5A26-11DD-B8C1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90017>

Junio C Hamano <gitster@pobox.com> writes:

> Various "values" given to the whitespace attribute actually act as if=
 they
> are sub-variables and obey the similar "[-]name" rule, but (1) that i=
s
> left unsaid, and (2) in that context '!' does not make sense so only =
'-'
> has any meaning.

Actually I take it back.  "!name to revert to unspecified and -name to =
unset"
really is about name; values to whitespace do not work like "sub-variab=
les"
at all.

> So I think Peter's patch is going in the right direction.

I've committed a much more simplified version.

-- >8 --
[PATCH] Documentation: clarify how to diable elements in core.whitespac=
e

Noticed by Peter Valdemar M=C3=B8rch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e784805..798b551 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -358,7 +358,8 @@ core.whitespace::
 	A comma separated list of common whitespace problems to
 	notice.  'git-diff' will use `color.diff.whitespace` to
 	highlight them, and 'git-apply --whitespace=3Derror' will
-	consider them as errors:
+	consider them as errors.  You can prefix `-` to disable
+	any of them (e.g. `-trailing-space`):
 +
 * `trailing-space` treats trailing whitespaces at the end of the line
   as an error (enabled by default).
