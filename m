From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: 22 Aug 2006 11:35:12 -0700
Message-ID: <86fyfohb4v.fsf@blue.stonehenge.com>
References: <200608211739.32993.jnareb@gmail.com>
	<7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org>
	<7vlkphqmac.fsf@assigned-by-dhcp.cox.net> <eceekl$b0l$2@sea.gmane.org>
	<7vodudno88.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 20:36:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFb5u-0001QQ-Ka
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 20:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWHVSfP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 14:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWHVSfP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 14:35:15 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:13647 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750775AbWHVSfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 14:35:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 7971A8FBDA;
	Tue, 22 Aug 2006 11:35:13 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 23566-01-31; Tue, 22 Aug 2006 11:35:13 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0995D8FBD7; Tue, 22 Aug 2006 11:35:13 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.10.7; tzolkin = 5 Manik; haab = 0 Mol
In-Reply-To: <7vodudno88.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25866>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> 	my @result = (); 
Junio>         for (my $i = 0; $i < @mapping; $i += 2) {
Junio>         	my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
Junio> 		if (defined $params{$name}) {
Junio> 			push @result, "$symbol=$params{$name}";
Junio> 		}
Junio> 	}
Junio>         return "$my_uri?" . esc_param(join(';', @result));
Junio> }

If you already depend on the LWP package, then the "URI" module
does precisely what you're reinventing.

my $uri = URI->new("http://host/base/path")
$uri->query_form(\%params);
my $result = $uri->as_string;

And I'd rely on Gisle Aas's experience about constructing these things
far more than the thread I've just witnessed here. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
