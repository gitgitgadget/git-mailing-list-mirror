From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unquote_c_style: fix off-by-one.
Date: Fri, 07 Mar 2008 13:28:13 -0800
Message-ID: <7vod9q1axe.fsf@gitster.siamese.dyndns.org>
References: <20080306212819.GA10873@artemis.madism.org>
 <7vbq5ra4gu.fsf@gitster.siamese.dyndns.org>
 <20080307004401.GA13642@artemis.madism.org>
 <20080307092544.GA22069@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Fri Mar 07 22:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXk7i-0005gK-Sv
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 22:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbYCGV2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 16:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760486AbYCGV2Z
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 16:28:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760275AbYCGV2Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 16:28:24 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CA2F71C99;
	Fri,  7 Mar 2008 16:28:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 12BB11C97; Fri,  7 Mar 2008 16:28:17 -0500 (EST)
In-Reply-To: <20080307092544.GA22069@chistera.yi.org> (Adeodato
 =?utf-8?Q?Sim=C3=B3's?= message of "Fri, 7 Mar 2008 10:25:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76527>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> * Pierre Habouzit [Fri, 07 Mar 2008 01:44:01 +0100]:
>
>> On Thu, Mar 06, 2008 at 10:10:41PM +0000, Junio C Hamano wrote:
>> > Pierre Habouzit <madcoder@debian.org> writes:
>
>> > > Thanks to Adeodato Sim=C3=B2 for having caught this.
>
>> > > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
>
>> > Thanks.  I would have appreciated a comment that said something ab=
out what
>> > external breakages this one caused, so that we can have an entry i=
n "bugs
>> > fixed" list.
>
>> > A quick audit of the existing callers suggests that it is fast-imp=
ort.
>
> Yes, it's fast-import. In particular, trying to rename a file whose n=
ame
> contains spaces:
>
>   R "file 1.txt" file 2.txt
>                 ^
>                 unquote_c_style() eats that space, thus fast-import
>                 fails with:
>
>                 fatal: Missing space after source: R "file 1.txt" fil=
e 2.txt
>

Thanks.
