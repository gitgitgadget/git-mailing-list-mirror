From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Sun, 29 Apr 2012 17:03:45 -0700
Message-ID: <7vvckihyqm.fsf@alter.siamese.dyndns.org>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
 <20120427082118.GA7257@dcvr.yhbt.net>
 <20120427082559.GC4023@login.drsnuggles.stderr.nl>
 <20120429082341.GA32664@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org,
	Matthijs Kooijman <matthijs@stdin.nl>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 02:04:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOe6E-0008J6-4K
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 02:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab2D3ADs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 20:03:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754555Ab2D3ADr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 20:03:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E71447A09;
	Sun, 29 Apr 2012 20:03:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w0SYql2fzpKBbTOuUbiH5wKlg88=; b=uNV8U7
	dQ7qVaBqYHPZ4yEhEDVJbXZgCgR9tY82K/vZwWwUdVxItomBC8zoKthe972we0CG
	xGwzsljk47Y7/wHh8iyNIBUBZwtdvt0VI+DNt9ch8hXZLilAeTtLxrBsPG7uN7Om
	9dK9INQl3xwdAsnm4YcUEQZ2fhJ99fIrA6ICY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v7z7hZxh9iukz7Vj4ezsaERT9Dz3bArA
	cIAPwsSBj1raa7dBAyh95yjBIk/Ybiqk9QtAAVzQvumWvnFHLrLaYbNilcr2cowN
	55+wuNtZLW6GqCpgj8a2WcIzI5sIoi33wbUmtXjRDq0zO9s6vsphPsihO3Oqv8kr
	wfAVE+8VYkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC7E87A04;
	Sun, 29 Apr 2012 20:03:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A5DD7A03; Sun, 29 Apr 2012
 20:03:46 -0400 (EDT)
In-Reply-To: <20120429082341.GA32664@dcvr.yhbt.net> (Eric Wong's message of
 "Sun, 29 Apr 2012 08:23:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4CCBBE2-9257-11E1-90CC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196522>

Eric Wong <normalperson@yhbt.net> writes:

> Matthijs Kooijman <matthijs@stdin.nl> wrote:
>> > > On Linux, this makes authentication using passwords from gnome-keyring
>> > > and kwallet work (only the former was tested). On Mac OS X, this allows
>> > > using the OS X Keychain.
>> Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
>
> Thanks Matthijs, pushed to master of git://bogomips.org/git-svn for
> Junio.
>
> (actually pushed the other night, but I got distracted before
>  sending this email :x)

Thanks. Pulled.

Eric, if it is not too much trouble, I'd appreciate an update to RelNotes
in pull requests.  I'll add the following to the "Foreign Interface"
section.

 Documentation/RelNotes/1.7.11.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/RelNotes/1.7.11.txt b/Documentation/RelNotes/1.7.11.txt
index af73659..3609042 100644
--- a/Documentation/RelNotes/1.7.11.txt
+++ b/Documentation/RelNotes/1.7.11.txt
@@ -47,6 +47,9 @@ Foreign Interface
  * "git svn" used to die with unwanted SIGPIPE when talking with HTTP
    server that uses keep-alive.
 
+ * "git svn" learned to use platform specific authentication
+   providers, e.g. gnome-keyring, kwallet, etc.
+
  * "git p4" has been moved out of contrib/ area.
 
 Performance
