From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads is  available
Date: Tue, 23 Mar 2010 22:09:35 +0100
Message-ID: <201003232209.35750.j6t@kdbg.org>
References: <cover.1267889072.git.j6t@kdbg.org> <201003232125.49933.j6t@kdbg.org> <7v7hp2rcn8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 22:11:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuBO5-0003Sv-7k
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 22:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab0CWVLk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 17:11:40 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:65060 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751963Ab0CWVLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 17:11:39 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B119810012;
	Tue, 23 Mar 2010 22:11:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D64CE19F6B8;
	Tue, 23 Mar 2010 22:09:35 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v7hp2rcn8.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143050>

On Dienstag, 23. M=E4rz 2010, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > BTW, the real fix for this potentially problematic case is to teach
> > pack-objects to create a pack file for a shallow clone. Then we don=
't
> > need this instance of an async procedure.
>
> I keep hearing "shallow clone" here, but doesn't "bundle -n 1" essent=
ially
> do something quite similar using pack-objects?  Do they make a call i=
nto
> pack-objects in a different way, and if so can we update "clone" to m=
imic
> how "bundle" drives pack-objects?

Both *current* implementations of shallow clone and bundle feed pack-ob=
jects=20
with rev-list output.

In the case of non-shallow clone, upload-pack does not need rev-list be=
cause=20
pack-objects can walk the revisions itself. I cannot tell what pack-obj=
ects=20
does not have that it cannot walk the revisions itself for shallow clon=
es.

-- Hannes
