From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v4] Git.pm: add test suite
Date: Tue, 17 Jun 2008 20:16:21 -0700
Message-ID: <7v63s7301m.fsf@gitster.siamese.dyndns.org>
References: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com>
 <4db23d5b625de1aa026cf4630d49b57fd3a09d07.1213685306.git.LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 05:17:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8oAr-0001L2-Q2
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 05:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883AbYFRDQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 23:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755673AbYFRDQf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 23:16:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbYFRDQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 23:16:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D09761289A;
	Tue, 17 Jun 2008 23:16:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA4CC12899; Tue, 17 Jun 2008 23:16:25 -0400 (EDT)
In-Reply-To: <4db23d5b625de1aa026cf4630d49b57fd3a09d07.1213685306.git.LeWiemann@gmail.com>
 (Lea Wiemann's message of "Tue, 17 Jun 2008 08:59:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F3059364-3CE4-11DD-9016-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85357>

Lea Wiemann <lewiemann@gmail.com> writes:

> diff --git a/t/t9700/test.pl b/t/t9700/test.pl
> new file mode 100755
> index 0000000..8318fec
> --- /dev/null
> +++ b/t/t9700/test.pl
> @@ -0,0 +1,99 @@
> +#!/usr/bin/perl
> +use lib (split(/:/, $ENV{GITPERLLIB}));
> +
> +use warnings;
> +use strict;
> +
> +use Test::More qw(no_plan);
> +
> +use Cwd;
> +use File::Basename;
> +use File::Temp;
> +use IO::String;

The system I first tried this did not have IO::String installed.  Is this
something we would want to rely on being available?

It also indicates a slight problem in test_external.  Can it become a bit
easier to tell such a basic problem apart from real test errors?  I needed
to look into /tmp/* to see where it is failing but it would be nice if we
can somehow see the breakage with "sh t9700-*.sh -v".
