From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/4] gitweb: show notes in shortlog view
Date: Sat, 6 Feb 2010 01:18:19 +0100
Message-ID: <201002060118.21137.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <1265300338-25021-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 01:18:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdYNe-0004e2-TY
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 01:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab0BFAS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 19:18:26 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:40663 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0BFASZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 19:18:25 -0500
Received: by bwz19 with SMTP id 19so303310bwz.28
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 16:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IlW3RvBCUAhIjHqiHwCXoPbz6fFXKqpg2zAlX2f2+iE=;
        b=tnVEnXb9oSOfkHvs+BosHSYEUywHShH+LZZJJV3uMJ3/2AxlcPe3MxJWQPajLTvldG
         UyDw5JswCs7Je7UizI+6zSULy7mWiziqxb3MJCZWqkehqrpfhN3W3yuIa5CqeYIPpnHb
         4QiWecKvy87X9D8fAxuN7XUlqctxUKLtXwrcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=daXfP6muPSSy5hMeIwDkSjC8kWERoJSX5SEIyRLGn9k6RjWbr+xhCoDchzrjY4Ugpc
         LI9g7rTUcgK9eAkv8t2V0wdypvD+17RxfPTmrvtbiBEBfWcea7fL4T2st5C0n62qSlaG
         XWcIkIJhbEqoqRgemWr+Xv+hvKd7RXKxt9pws=
Received: by 10.204.151.91 with SMTP id b27mr2202811bkw.110.1265415503541;
        Fri, 05 Feb 2010 16:18:23 -0800 (PST)
Received: from ?192.168.1.13? (abvb35.neoplus.adsl.tpnet.pl [83.8.199.35])
        by mx.google.com with ESMTPS id 14sm905879bwz.5.2010.02.05.16.18.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 16:18:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1265300338-25021-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139129>

On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:

> Subject: [PATCH 2/4] gitweb: show notes in shortlog view

Is it RFC?

Why it is only for 'shortlog' view, and not also for 'history' which is
also shortlog-like view?  Or is there reason why it is not present for
'history' view?

> The presence of the note is shown by a small icon, hovering on which
> reveals the actual note content.

Signoff?

> ---
>  gitweb/gitweb.css  |   29 +++++++++++++++++++++++++++++
>  gitweb/gitweb.perl |   30 +++++++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 50067f2..7d1836b 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -572,3 +572,32 @@ span.match {
>  div.binary {
>  	font-style: italic;
>  }
> +
> +span.notes {
> +	float:right;
> +	position:relative;
> +}
> +
> +span.notes span.note-container:before {
> +	content: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAIAgMAAAC5YVYYAAAAAXNSR0IArs4c6QAAAAlQTFRFAABnybuD//+t5rXizQAAAAF0Uk5TAEDm2GYAAAABYktHRACIBR1IAAAAGElEQVQI12MIDWXIWglDQHYIQ1YAQ6gDAFWPBrAKFe0fAAAAAElFTkSuQmCC');
> +}

Not all web browsers support ':before' pseudo-element, and 'content'
(pseudo-)property.

Not all web browsers support 'data:' URI schema in CSS; also such image
cannot be cached (on the other hand it doesn't require extra TCP 
connection on first access, and CSS file is cached anyway).

On the other hand adding extra images to gitweb would probably require
additional (yet another) build time parameter to tell where static
images are (besides logo and favicon).

So perhaps it is good solution, at least for a first attempt.

[...]
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9ba5815..1701ed1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1628,6 +1628,33 @@ sub format_subject_html {
>  	}
>  }
>  
> +# display notes next to a commit
> +sub format_notes_html {
> +	my %notes = %{$_[0]};

Why not use 'my $notes = shift;', and later '%$notes'?

> +	my $ret = "";

Perhaps $return or $result would be a better name, to better distinguish
it from visually similar $ref (see $ref vs $res);

> +	while (my ($ref, $text) = each %notes) {
> +		# remove 'refs/notes/' and an optional final s
> +		$ref =~ s/^refs\/notes\///;

You can use different delimiter than / to avoid 'leaning toothpick'
syndrome, e.g.: $ref =~ s!^refs/notes/!!;

> +		$ref =~ s/s$//;
> +
> +		# double markup is needed to allow pure CSS cross-browser 'popup'
> +		# of the note
> +		$ret .= "<span title='$ref' class='note-container $ref'>";
> +		$ret .= "<span title='$ref' class='note $ref'>";
> +		foreach my $line (split /\n/, $text) {
> +			$ret .= esc_html($line) . "<br/>";

Probably would want

   			$ret .= esc_html($line) . "<br/>\n";

here.  Or do we want single string here?


Also, do you want/need final <br>?  If not, perhaps

   		join("<br/>", map { esc_html($_) } split(/\n/, $text);

would be a better solution (you can always add final "<br/>" later)?

> +		}
> +		$ret .= "</span></span>";
> +	}
> +	if ($ret) {
> +		return "<span class='notes'>$ret</span>";
> +	} else {
> +		return $ret;
> +	}
> +
> +
> +}
> +
>  # Rather than recomputing the url for an email multiple times, we cache it
>  # after the first hit. This gives a visible benefit in views where the avatar
>  # for the same email is used repeatedly (e.g. shortlog).
> @@ -4595,6 +4622,7 @@ sub git_shortlog_body {
>  		my %co = %{$commitlist->[$i]};
>  		my $commit = $co{'id'};
>  		my $ref = format_ref_marker($refs, $commit);
> +		my $notes = format_notes_html($co{'notes'});
>  		if ($alternate) {
>  			print "<tr class=\"dark\">\n";
>  		} else {
> @@ -4605,7 +4633,7 @@ sub git_shortlog_body {
>  		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
>  		      format_author_html('td', \%co, 10) . "<td>";
>  		print format_subject_html($co{'title'}, $co{'title_short'},
> -		                          href(action=>"commit", hash=>$commit), $ref);
> +		                          href(action=>"commit", hash=>$commit), $ref . $notes);
>  		print "</td>\n" .
>  		      "<td class=\"link\">" .
>  		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .

Nice.

-- 
Jakub Narebski
Poland
