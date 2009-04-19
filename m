From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and 
 error-handling in send_message's sendmail code
Date: Sat, 18 Apr 2009 21:44:14 -0700
Message-ID: <7vskk5s15t.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <76718490904181851g2701ce59x614ea60452b914ce@mail.gmail.com>
 <b4087cc50904181913g117937le333c3b255f7d184@mail.gmail.com>
 <18071eea0904181917u7c7187bubc8fab6ede2d19ef@mail.gmail.com>
 <b4087cc50904181943t71d501a6r51bb4cc846f32f78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 06:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvOut-0004vO-VL
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 06:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbZDSEod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 00:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbZDSEod
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 00:44:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZDSEoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 00:44:32 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 094ECAB8D7;
	Sun, 19 Apr 2009 00:44:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B5572AB8D3; Sun,
 19 Apr 2009 00:44:23 -0400 (EDT)
In-Reply-To: <b4087cc50904181943t71d501a6r51bb4cc846f32f78@mail.gmail.com>
 (Michael Witten's message of "Sat, 18 Apr 2009 21:43:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C50C6E9E-2C9C-11DE-AD58-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116882>

Michael Witten <mfwitten@gmail.com> writes:

> On Sat, Apr 18, 2009 at 21:17, Thomas Adam <thomas.adam22@gmail.com> =
wrote:
>> More concerning is that it's a perl 5.10ism -- you cannot assume tha=
t
>> perl 5.10 is installed on all platforms. =C2=A0I really wouldn't use=
 this
>> construct.
>
> See that's the thing: How am I supposed to know it's a perl 5.10ism?

Read perldelta.pod  They come with your Perl distribution.

Debian based distro installs them in

    /usr/share/perl/5.10.0/pod/perl*delta.pod

and Fedora seems to have them in

    /usr/lib/perl5/5.10.0/pod/perl*delta.pod

I think we stick to something like early 5.8 to support platforms with
infrequent updates to Perl.
