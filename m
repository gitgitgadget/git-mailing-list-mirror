From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Gui does not want to work on chunk level
Date: Thu, 04 Sep 2008 22:18:38 -0700
Message-ID: <7v63pbyxu9.fsf@gitster.siamese.dyndns.org>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com>
 <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com>
 <20080903230814.GJ28315@spearce.org>
 <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com>
 <20080904143723.GB23708@spearce.org>
 <c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com>
 <20080905045327.GA31166@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gladysh <agladysh@gmail.com>, git-users@googlegroups.com,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 07:20:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbTjn-0002VT-79
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 07:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbYIEFSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 01:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbYIEFSw
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 01:18:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYIEFSv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 01:18:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 22F085DEE1;
	Fri,  5 Sep 2008 01:18:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B834A5DEDE; Fri,  5 Sep 2008 01:18:40 -0400 (EDT)
In-Reply-To: <20080905045327.GA31166@spearce.org> (Shawn O. Pearce's message
 of "Thu, 4 Sep 2008 21:53:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1E6C2460-7B0A-11DD-A02C-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94990>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> git-gui was incorrectly parsing "--- foo" as the old file name
> in the file header, causing it to generate a bad patch file when
> the user tried to stage or unstage a hunk or the selected line.
> We need to keep track of where we are in the parsing so that we do
> not misread a deletion or addition record as part of the header.

While keeping track of state is obviously a good change, it also might be
worth noticing "@@ -k,l +m,n @@" header and actively using the
information.
