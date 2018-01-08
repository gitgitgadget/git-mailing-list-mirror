Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485B21F406
	for <e@80x24.org>; Mon,  8 Jan 2018 11:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbeAHL4T (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 06:56:19 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:41443 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932413AbeAHL4S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 06:56:18 -0500
Received: by mail-wm0-f53.google.com with SMTP id g75so13707567wme.0
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 03:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=boSMC9/A2rTs3vRKJUScBYHNAP6LisIuhyM8+02SGEI=;
        b=W1IDkes84GJ3JJ6zCrur+PY/rNRBdRZTfLth2F2Ak6psFt8dnjtot1AQTPBiJvWrjJ
         kxEcONy1NlLRfH+tXJCPG8yrILINBvI+gG8TRyPhTO9DYaTExNzzoHnIS/qthyPoMsZY
         Y5obaYoTiEJK2rqWWKKBoMQ6IhKVa7ryMWErQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=boSMC9/A2rTs3vRKJUScBYHNAP6LisIuhyM8+02SGEI=;
        b=SM6YYSBOXQw58fNhxDFoOknFOTtoCy0WNTvv02IwPt6SzO0imBlK/qv6kCB4ustXjt
         9A/25yAQkd9wpIc4YGVV3U+hh2fk4vkN7yNDMqABvaBB6rbZqvpIlQq42v3zVTUDi/j+
         DgKhBuw92309Lqn+tLDvUm8aUhyUYZCFBnCvRL7MuMppCWuBec5BoSuBSm0zWT1HckJ+
         Y7yC233E+N7XBEDpCvBbR/FF8c2LQqHXIp0rC8AJQ6iWYuDcFWdYAI67baY7XSdaU6xE
         njQvd6JNFPJfjyvym6Ln7SRdGYaSCBnxKjOU3zS47++F6Dmvfec0nVixSLT0DGwvwZI0
         05fA==
X-Gm-Message-State: AKGB3mJsRVVt3QL6gJdVg0etsDpvFNEyWqs/kB5zRyLjV7rQYGDOzNOV
        OfgQyhFjwsXX4h9B92QW3sKNzA==
X-Google-Smtp-Source: ACJfBotn7xC50W+nRKPpvmnP5kqT9WrHLwEjtDhzOf0nBEyoAURgaB1IqQBF6iyQu+ikDDhzsjVaog==
X-Received: by 10.28.238.72 with SMTP id m69mr8737231wmh.17.1515412576568;
        Mon, 08 Jan 2018 03:56:16 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t61sm27141304wrc.21.2018.01.08.03.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 03:56:15 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 217CF3E037F;
        Mon,  8 Jan 2018 11:56:15 +0000 (GMT)
References: <1515177413-12526-1-git-send-email-git@matthieu-moy.fr> <1515407674-5233-1-git-send-email-git@matthieu-moy.fr>
User-agent: mu4e 1.0-alpha3; emacs 26.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH v3 1/3] send-email: add and use a local copy of Mail::Address
In-reply-to: <1515407674-5233-1-git-send-email-git@matthieu-moy.fr>
Date:   Mon, 08 Jan 2018 11:56:15 +0000
Message-ID: <87incco97k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Matthieu Moy <git@matthieu-moy.fr> writes:

> We used to have two versions of the email parsing code. Our
> parse_mailboxes (in Git.pm), and Mail::Address which we used if
> installed. Unfortunately, both versions have different sets of bugs, and
> changing the behavior of git depending on whether Mail::Address is
> installed was a bad idea.
>
> A first attempt to solve this was cc90750 (send-email: don't use
> Mail::Address, even if available, 2017-08-23), but it turns out our
> parse_mailboxes is too buggy for some uses. For example the lack of
> nested comments support breaks get_maintainer.pl in the Linux kernel
> tree:
>
>   https://public-inbox.org/git/20171116154814.23785-1-alex.bennee@linaro.=
org/
>
> This patch goes the other way: use Mail::Address anyway, but have a
> local copy from CPAN as a fallback, when the system one is not
> available.
>
> The duplicated script is small (276 lines of code) and stable in time.
> Maintaining the local copy should not be an issue, and will certainly be
> less burden than maintaining our own parse_mailboxes.
>
> Another option would be to consider Mail::Address as a hard dependency,
> but it's easy enough to save the trouble of extra-dependency to the end
> user or packager.
>
> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
> No change since v2.
>
>  git-send-email.perl               |   3 +-
>  perl/Git/FromCPAN/Mail/Address.pm | 276 ++++++++++++++++++++++++++++++++=
++++++
>  perl/Git/Mail/Address.pm          |  24 ++++
>  3 files changed, 302 insertions(+), 1 deletion(-)
>  create mode 100644 perl/Git/FromCPAN/Mail/Address.pm
>  create mode 100755 perl/Git/Mail/Address.pm
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index edcc6d3..340b5c8 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -30,6 +30,7 @@ use Error qw(:try);
>  use Cwd qw(abs_path cwd);
>  use Git;
>  use Git::I18N;
> +use Git::Mail::Address;
>
>  Getopt::Long::Configure qw/ pass_through /;
>
> @@ -489,7 +490,7 @@ my ($repoauthor, $repocommitter);
>  ($repocommitter) =3D Git::ident_person(@repo, 'committer');
>
>  sub parse_address_line {
> -	return Git::parse_mailboxes($_[0]);
> +	return map { $_->format } Mail::Address->parse($_[0]);
>  }
>
>  sub split_addrs {
> diff --git a/perl/Git/FromCPAN/Mail/Address.pm b/perl/Git/FromCPAN/Mail/A=
ddress.pm
> new file mode 100644
> index 0000000..13b2ff7
> --- /dev/null
> +++ b/perl/Git/FromCPAN/Mail/Address.pm
> @@ -0,0 +1,276 @@
> +# Copyrights 1995-2017 by [Mark Overmeer <perl@overmeer.net>].
> +#  For other contributors see ChangeLog.
> +# See the manual pages for details on the licensing terms.
> +# Pod stripped from pm file by OODoc 2.02.
> +package Mail::Address;
> +use vars '$VERSION';
> +$VERSION =3D '2.19';
> +
> +use strict;
> +
> +use Carp;
> +
> +# use locale;   removed in version 1.78, because it causes taint problems
> +
> +sub Version { our $VERSION }
> +
> +
> +
> +# given a comment, attempt to extract a person's name
> +sub _extract_name
> +{   # This function can be called as method as well
> +    my $self =3D @_ && ref $_[0] ? shift : undef;
> +
> +    local $_ =3D shift
> +        or return '';
> +
> +    # Using encodings, too hard. See Mail::Message::Field::Full.
> +    return '' if m/\=3D\?.*?\?\=3D/;
> +
> +    # trim whitespace
> +    s/^\s+//;
> +    s/\s+$//;
> +    s/\s+/ /;
> +
> +    # Disregard numeric names (e.g. 123456.1234@compuserve.com)
> +    return "" if /^[\d ]+$/;
> +
> +    s/^\((.*)\)$/$1/; # remove outermost parenthesis
> +    s/^"(.*)"$/$1/;   # remove outer quotation marks
> +    s/\(.*?\)//g;     # remove minimal embedded comments
> +    s/\\//g;          # remove all escapes
> +    s/^"(.*)"$/$1/;   # remove internal quotation marks
> +    s/^([^\s]+) ?, ?(.*)$/$2 $1/; # reverse "Last, First M." if applicab=
le
> +    s/,.*//;
> +
> +    # Change casing only when the name contains only upper or only
> +    # lower cased characters.
> +    unless( m/[A-Z]/ && m/[a-z]/ )
> +    {   # Set the case of the name to first char upper rest lower
> +        s/\b(\w+)/\L\u$1/igo;  # Upcase first letter on name
> +        s/\bMc(\w)/Mc\u$1/igo; # Scottish names such as 'McLeod'
> +        s/\bo'(\w)/O'\u$1/igo; # Irish names such as 'O'Malley, O'Reilly'
> +        s/\b(x*(ix)?v*(iv)?i*)\b/\U$1/igo; # Roman numerals, eg 'Level I=
II Support'
> +    }
> +
> +    # some cleanup
> +    s/\[[^\]]*\]//g;
> +    s/(^[\s'"]+|[\s'"]+$)//g;
> +    s/\s{2,}/ /g;
> +
> +    $_;
> +}
> +
> +sub _tokenise
> +{   local $_ =3D join ',', @_;
> +    my (@words,$snippet,$field);
> +
> +    s/\A\s+//;
> +    s/[\r\n]+/ /g;
> +
> +    while ($_ ne '')
> +    {   $field =3D '';
> +        if(s/^\s*\(/(/ )    # (...)
> +        {   my $depth =3D 0;
> +
> +     PAREN: while(s/^(\(([^\(\)\\]|\\.)*)//)
> +            {   $field .=3D $1;
> +                $depth++;
> +                while(s/^(([^\(\)\\]|\\.)*\)\s*)//)
> +                {   $field .=3D $1;
> +                    last PAREN unless --$depth;
> +	            $field .=3D $1 if s/^(([^\(\)\\]|\\.)+)//;
> +                }
> +            }
> +
> +            carp "Unmatched () '$field' '$_'"
> +                if $depth;
> +
> +            $field =3D~ s/\s+\Z//;
> +            push @words, $field;
> +
> +            next;
> +        }
> +
> +        if( s/^("(?:[^"\\]+|\\.)*")\s*//       # "..."
> +         || s/^(\[(?:[^\]\\]+|\\.)*\])\s*//    # [...]
> +         || s/^([^\s()<>\@,;:\\".[\]]+)\s*//
> +         || s/^([()<>\@,;:\\".[\]])\s*//
> +          )
> +        {   push @words, $1;
> +            next;
> +        }
> +
> +        croak "Unrecognised line: $_";
> +    }
> +
> +    push @words, ",";
> +    \@words;
> +}
> +
> +sub _find_next
> +{   my ($idx, $tokens, $len) =3D @_;
> +
> +    while($idx < $len)
> +    {   my $c =3D $tokens->[$idx];
> +        return $c if $c eq ',' || $c eq ';' || $c eq '<';
> +        $idx++;
> +    }
> +
> +    "";
> +}
> +
> +sub _complete
> +{   my ($class, $phrase, $address, $comment) =3D @_;
> +
> +    @$phrase || @$comment || @$address
> +       or return undef;
> +
> +    my $o =3D $class->new(join(" ",@$phrase), join("",@$address), join("=
 ",@$comment));
> +    @$phrase =3D @$address =3D @$comment =3D ();
> +    $o;
> +}
> +
> +#------------
> +
> +sub new(@)
> +{   my $class =3D shift;
> +    bless [@_], $class;
> +}
> +
> +
> +sub parse(@)
> +{   my $class =3D shift;
> +    my @line  =3D grep {defined} @_;
> +    my $line  =3D join '', @line;
> +
> +    my (@phrase, @comment, @address, @objs);
> +    my ($depth, $idx) =3D (0, 0);
> +
> +    my $tokens  =3D _tokenise @line;
> +    my $len     =3D @$tokens;
> +    my $next    =3D _find_next $idx, $tokens, $len;
> +
> +    local $_;
> +    for(my $idx =3D 0; $idx < $len; $idx++)
> +    {   $_ =3D $tokens->[$idx];
> +
> +        if(substr($_,0,1) eq '(') { push @comment, $_ }
> +        elsif($_ eq '<')    { $depth++ }
> +        elsif($_ eq '>')    { $depth-- if $depth }
> +        elsif($_ eq ',' || $_ eq ';')
> +        {   warn "Unmatched '<>' in $line" if $depth;
> +            my $o =3D $class->_complete(\@phrase, \@address, \@comment);
> +            push @objs, $o if defined $o;
> +            $depth =3D 0;
> +            $next =3D _find_next $idx+1, $tokens, $len;
> +        }
> +        elsif($depth)       { push @address, $_ }
> +        elsif($next eq '<') { push @phrase,  $_ }
> +        elsif( /^[.\@:;]$/ || !@address || $address[-1] =3D~ /^[.\@:;]$/=
 )
> +        {   push @address, $_ }
> +        else
> +        {   warn "Unmatched '<>' in $line" if $depth;
> +            my $o =3D $class->_complete(\@phrase, \@address, \@comment);
> +            push @objs, $o if defined $o;
> +            $depth =3D 0;
> +            push @address, $_;
> +        }
> +    }
> +    @objs;
> +}
> +
> +#------------
> +
> +sub phrase  { shift->set_or_get(0, @_) }
> +sub address { shift->set_or_get(1, @_) }
> +sub comment { shift->set_or_get(2, @_) }
> +
> +sub set_or_get($)
> +{   my ($self, $i) =3D (shift, shift);
> +    @_ or return $self->[$i];
> +
> +    my $val =3D $self->[$i];
> +    $self->[$i] =3D shift if @_;
> +    $val;
> +}
> +
> +
> +my $atext =3D '[\-\w !#$%&\'*+/=3D?^`{|}~]';
> +sub format
> +{   my @addrs;
> +
> +    foreach (@_)
> +    {   my ($phrase, $email, $comment) =3D @$_;
> +        my @addr;
> +
> +        if(defined $phrase && length $phrase)
> +        {   push @addr
> +              , $phrase =3D~ /^(?:\s*$atext\s*)+$/o ? $phrase
> +              : $phrase =3D~ /(?<!\\)"/             ? $phrase
> +              :                                    qq("$phrase");
> +
> +            push @addr, "<$email>"
> +                if defined $email && length $email;
> +        }
> +        elsif(defined $email && length $email)
> +        {   push @addr, $email;
> +        }
> +
> +        if(defined $comment && $comment =3D~ /\S/)
> +        {   $comment =3D~ s/^\s*\(?/(/;
> +            $comment =3D~ s/\)?\s*$/)/;
> +        }
> +
> +        push @addr, $comment
> +            if defined $comment && length $comment;
> +
> +        push @addrs, join(" ", @addr)
> +            if @addr;
> +    }
> +
> +    join ", ", @addrs;
> +}
> +
> +#------------
> +
> +sub name
> +{   my $self   =3D shift;
> +    my $phrase =3D $self->phrase;
> +    my $addr   =3D $self->address;
> +
> +    $phrase    =3D $self->comment
> +        unless defined $phrase && length $phrase;
> +
> +    my $name   =3D $self->_extract_name($phrase);
> +
> +    # first.last@domain address
> +    if($name eq '' && $addr =3D~ /([^\%\.\@_]+([\._][^\%\.\@_]+)+)[\@\%]=
/)
> +    {   ($name  =3D $1) =3D~ s/[\._]+/ /g;
> +	$name   =3D _extract_name $name;
> +    }
> +
> +    if($name eq '' && $addr =3D~ m#/g=3D#i)    # X400 style address
> +    {   my ($f) =3D $addr =3D~ m#g=3D([^/]*)#i;
> +	my ($l) =3D $addr =3D~ m#s=3D([^/]*)#i;
> +	$name   =3D _extract_name "$f $l";
> +    }
> +
> +    length $name ? $name : undef;
> +}
> +
> +
> +sub host
> +{   my $addr =3D shift->address || '';
> +    my $i    =3D rindex $addr, '@';
> +    $i >=3D 0 ? substr($addr, $i+1) : undef;
> +}
> +
> +
> +sub user
> +{   my $addr =3D shift->address || '';
> +    my $i    =3D rindex $addr, '@';
> +    $i >=3D 0 ? substr($addr,0,$i) : $addr;
> +}
> +
> +1;
> diff --git a/perl/Git/Mail/Address.pm b/perl/Git/Mail/Address.pm
> new file mode 100755
> index 0000000..2ce3e84
> --- /dev/null
> +++ b/perl/Git/Mail/Address.pm
> @@ -0,0 +1,24 @@
> +package Git::Mail::Address;
> +use 5.008;
> +use strict;
> +use warnings;
> +
> +=3Dhead1 NAME
> +
> +Git::Mail::Address - Wrapper for the L<Mail::Address> module, in case it=
's not installed
> +
> +=3Dhead1 DESCRIPTION
> +
> +This module is only intended to be used for code shipping in the
> +C<git.git> repository. Use it for anything else at your peril!
> +
> +=3Dcut
> +
> +eval {
> +    require Mail::Address;
> +    1;
> +} or do {
> +    require Git::FromCPAN::Mail::Address;
> +};
> +
> +1;


--
Alex Benn=C3=A9e
