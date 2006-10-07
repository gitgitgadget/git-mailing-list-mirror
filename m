From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Cleanup Git logo and Git logo target generation
Date: Sat, 7 Oct 2006 11:58:25 +0200
Message-ID: <200610071158.26211.jnareb@gmail.com>
References: <20060919212725.GA13132@pasky.or.cz> <200610061231.06017.jnareb@gmail.com> <7viriwwmid.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 11:57:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW8wD-0006zo-NL
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 11:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWJGJ5l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 05:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWJGJ5l
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 05:57:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:52643 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750764AbWJGJ5l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 05:57:41 -0400
Received: by ug-out-1314.google.com with SMTP id o38so416404ugd
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 02:57:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iro5H2YzPhv8w+a9z5QBq9Owum2WOYz5O4GtirjF9563hWmhZg0DWc6UvEacj7OWTGqek5T3o03xa60Yxdoem8zN1DllmCvbbqXbtXp4UddXEYN1TQT7dXF1rJsIdQYYh6bWtBF3gBlygNWt2/ZZ8xbWkQssZfKmcV97a01zP0A=
Received: by 10.67.89.5 with SMTP id r5mr4364424ugl;
        Sat, 07 Oct 2006 02:57:39 -0700 (PDT)
Received: from host-81-190-22-223.torun.mm.pl ( [81.190.22.223])
        by mx.google.com with ESMTP id x37sm2825525ugc.2006.10.07.02.57.38;
        Sat, 07 Oct 2006 02:57:39 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7viriwwmid.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28466>

Junio C Hamano wrote:

> Having said that, I am wondering if it is worth doing something
> like this:
> 
> 
> sub img_button {
> 	my $it = $_[0];
> 	my @attr = ();
>         for my $attr (qw(src width height alt class id)) {
> 		next unless exists $it->{$attr};
>                 push @attr, "$attr=\"" . esc_attr($it->{$attr}) . '"';
> 	}
> 	my $img = '<img ' . join(' ', @attr) . ' />';
> 	print $cgi->a({ -href => esc_url($it->{'url'}),
>         		-title => esc_attr($it->{'title'}),
>                       }, $img);
> }
> 
> our %logo = (
> 	# logo image button
> 	src => '++GITWEB_LOGO++',
>         width => 72,
>         height => 27,
> 	alt => 'git logo',
> 
> 	# where that link leads to
>         url => 'http:/git.or.cz/',
> 	title => 'git homepage',
> );

You forgot to add style, i.e. either id => 'logo' or class => 'logo'. 

I'm not sure if it is worth complication. We have similar situation 
(although without image) with $home_link and $home_link_str (as with 
$logo, $logo_url, $logo_label).

I wonder how many people use non-standard logo image, or non standard 
favicon...
-- 
Jakub Narebski
Poland
