Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8991F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031838AbeBNWWb (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:22:31 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39206 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:22:14 -0500
Received: by mail-wm0-f68.google.com with SMTP id b21so24600668wme.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kaHMiEBxhCA/Ff1W0MDJ0/g9iAUBbjH+Qhp9ylbJUto=;
        b=uV1J2s677n4AL1VTrz3sbMdRuH1vXb6UM97y5DUDKcLEoeNMn4IAC092ZcFriw6dVW
         2auamZlFDd/4yW4srJ3mjoQLPWkzk5zjiAg7c1a3SuWmRkhhkIW2UcnxQFinS4d3hHb7
         64S5Smk2t+BzMR1L4hSmdqXRuL0TqgAlhK4izBB5GTvDfBiTUsz5xgxzYZzZSU0AB1yU
         x8J6PsMtBTQ/sWx0C3VaORwQixqGTVtZMoInmb+krAN90SBV2Ssk9+F1X/AJi7TyM6qn
         Vh0hQ7+3A/3EnRsgZCl+q/0m+9N9/KXX5oumq2yGnB38c0Hq7g0qi2X/Ifi9nHpeFq2P
         RvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaHMiEBxhCA/Ff1W0MDJ0/g9iAUBbjH+Qhp9ylbJUto=;
        b=A3UmMZmhKdvIiF13bfzbKlccUhARzmKg1fllctcXjba2g4TrRHE1mVtVJxeZ0Dr24H
         LPCUhxdGYQuFaqebbP0ApiQhSc42krJPgjgghpr8jbeZS/da4zMvvpTHWDfjTRgODnNB
         4iDLp4uEsl5SLHlIAWmXFFVqKa6pz6P54Pz/IpZG6N4UkBUzMIDrOzfw5WkZnNaE53cV
         Q5oDx75LkhMPuyORWO2m9dT8z/NSG/WyDAAMqOC04DkdiY+ikQ+Mvx8SwDBNtKfro5ed
         shRLUiZldsc2icHvZuy+n+KVBm2M3cAAJ3EKGUhvxE9Hh/JdICy2F6s9ehljpe52tLUW
         60Wg==
X-Gm-Message-State: APf1xPADaVwqk1BprM4pYUkRBAjxr2Y8iae5no3dFYLgCuzGTNOYVV1Z
        enz41Xopg4KsES8ZN3cC2CN3xHzr
X-Google-Smtp-Source: AH8x224GAiEsPNnqyxs4pIHdcFiFPcxUH5JKW3oPIPCGbCa+y0Mjog7sNicj6tWPhIyUpUTwCDDpHg==
X-Received: by 10.28.193.78 with SMTP id r75mr362041wmf.135.1518646932666;
        Wed, 14 Feb 2018 14:22:12 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a14sm13191356wrf.22.2018.02.14.14.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 14:22:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] perl: update our copy of Mail::Address
Date:   Wed, 14 Feb 2018 22:21:43 +0000
Message-Id: <20180214222146.10655-6-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update our copy of Mail::Address from 2.19 (Aug 22, 2017) to 2.20 (Jan
23, 2018). This should be a trivial update[1] but it seems the version
Matthieu Moy imported in bd869f67b9 ("send-email: add and use a local
copy of Mail::Address", 2018-01-05) doesn't correspond to any 2.19
version found on the CPAN. From the comment at the top of the file it
looks like some OS version with the POD stripped, and with different
indentation.

Let's instead use the upstream version as-is, and without copyright
notices stripped. Like Error.pm this doesn't cleanly pass --check, so
add a .gitattributes file to ignore the errors.

1. https://metacpan.org/diff/file?target=MARKOV/MailTools-2.20/lib%2FMail%2FAddress.pod&source=MARKOV%2FMailTools-2.19%2Flib%2FMail%2FAddress.pod

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git/FromCPAN/Mail/.gitattributes |   1 +
 perl/Git/FromCPAN/Mail/Address.pm     | 436 +++++++++++++---------------------
 2 files changed, 163 insertions(+), 274 deletions(-)
 create mode 100644 perl/Git/FromCPAN/Mail/.gitattributes

diff --git a/perl/Git/FromCPAN/Mail/.gitattributes b/perl/Git/FromCPAN/Mail/.gitattributes
new file mode 100644
index 0000000000..94f3e5bb86
--- /dev/null
+++ b/perl/Git/FromCPAN/Mail/.gitattributes
@@ -0,0 +1 @@
+/Address.pm whitespace=-trailing-space
diff --git a/perl/Git/FromCPAN/Mail/Address.pm b/perl/Git/FromCPAN/Mail/Address.pm
index 13b2ff7d05..ee333e0f5a 100644
--- a/perl/Git/FromCPAN/Mail/Address.pm
+++ b/perl/Git/FromCPAN/Mail/Address.pm
@@ -1,276 +1,164 @@
-# Copyrights 1995-2017 by [Mark Overmeer <perl@overmeer.net>].
-#  For other contributors see ChangeLog.
-# See the manual pages for details on the licensing terms.
-# Pod stripped from pm file by OODoc 2.02.
-package Mail::Address;
-use vars '$VERSION';
-$VERSION = '2.19';
-
-use strict;
-
-use Carp;
-
-# use locale;   removed in version 1.78, because it causes taint problems
-
-sub Version { our $VERSION }
-
-
-
-# given a comment, attempt to extract a person's name
-sub _extract_name
-{   # This function can be called as method as well
-    my $self = @_ && ref $_[0] ? shift : undef;
-
-    local $_ = shift
-        or return '';
-
-    # Using encodings, too hard. See Mail::Message::Field::Full.
-    return '' if m/\=\?.*?\?\=/;
-
-    # trim whitespace
-    s/^\s+//;
-    s/\s+$//;
-    s/\s+/ /;
-
-    # Disregard numeric names (e.g. 123456.1234@compuserve.com)
-    return "" if /^[\d ]+$/;
-
-    s/^\((.*)\)$/$1/; # remove outermost parenthesis
-    s/^"(.*)"$/$1/;   # remove outer quotation marks
-    s/\(.*?\)//g;     # remove minimal embedded comments
-    s/\\//g;          # remove all escapes
-    s/^"(.*)"$/$1/;   # remove internal quotation marks
-    s/^([^\s]+) ?, ?(.*)$/$2 $1/; # reverse "Last, First M." if applicable
-    s/,.*//;
-
-    # Change casing only when the name contains only upper or only
-    # lower cased characters.
-    unless( m/[A-Z]/ && m/[a-z]/ )
-    {   # Set the case of the name to first char upper rest lower
-        s/\b(\w+)/\L\u$1/igo;  # Upcase first letter on name
-        s/\bMc(\w)/Mc\u$1/igo; # Scottish names such as 'McLeod'
-        s/\bo'(\w)/O'\u$1/igo; # Irish names such as 'O'Malley, O'Reilly'
-        s/\b(x*(ix)?v*(iv)?i*)\b/\U$1/igo; # Roman numerals, eg 'Level III Support'
-    }
+=encoding utf8
 
-    # some cleanup
-    s/\[[^\]]*\]//g;
-    s/(^[\s'"]+|[\s'"]+$)//g;
-    s/\s{2,}/ /g;
-
-    $_;
-}
-
-sub _tokenise
-{   local $_ = join ',', @_;
-    my (@words,$snippet,$field);
-
-    s/\A\s+//;
-    s/[\r\n]+/ /g;
-
-    while ($_ ne '')
-    {   $field = '';
-        if(s/^\s*\(/(/ )    # (...)
-        {   my $depth = 0;
-
-     PAREN: while(s/^(\(([^\(\)\\]|\\.)*)//)
-            {   $field .= $1;
-                $depth++;
-                while(s/^(([^\(\)\\]|\\.)*\)\s*)//)
-                {   $field .= $1;
-                    last PAREN unless --$depth;
-	            $field .= $1 if s/^(([^\(\)\\]|\\.)+)//;
-                }
-            }
-
-            carp "Unmatched () '$field' '$_'"
-                if $depth;
-
-            $field =~ s/\s+\Z//;
-            push @words, $field;
-
-            next;
-        }
-
-        if( s/^("(?:[^"\\]+|\\.)*")\s*//       # "..."
-         || s/^(\[(?:[^\]\\]+|\\.)*\])\s*//    # [...]
-         || s/^([^\s()<>\@,;:\\".[\]]+)\s*//
-         || s/^([()<>\@,;:\\".[\]])\s*//
-          )
-        {   push @words, $1;
-            next;
-        }
-
-        croak "Unrecognised line: $_";
-    }
-
-    push @words, ",";
-    \@words;
-}
-
-sub _find_next
-{   my ($idx, $tokens, $len) = @_;
-
-    while($idx < $len)
-    {   my $c = $tokens->[$idx];
-        return $c if $c eq ',' || $c eq ';' || $c eq '<';
-        $idx++;
-    }
-
-    "";
-}
-
-sub _complete
-{   my ($class, $phrase, $address, $comment) = @_;
-
-    @$phrase || @$comment || @$address
-       or return undef;
-
-    my $o = $class->new(join(" ",@$phrase), join("",@$address), join(" ",@$comment));
-    @$phrase = @$address = @$comment = ();
-    $o;
-}
-
-#------------
-
-sub new(@)
-{   my $class = shift;
-    bless [@_], $class;
-}
-
-
-sub parse(@)
-{   my $class = shift;
-    my @line  = grep {defined} @_;
-    my $line  = join '', @line;
-
-    my (@phrase, @comment, @address, @objs);
-    my ($depth, $idx) = (0, 0);
-
-    my $tokens  = _tokenise @line;
-    my $len     = @$tokens;
-    my $next    = _find_next $idx, $tokens, $len;
-
-    local $_;
-    for(my $idx = 0; $idx < $len; $idx++)
-    {   $_ = $tokens->[$idx];
-
-        if(substr($_,0,1) eq '(') { push @comment, $_ }
-        elsif($_ eq '<')    { $depth++ }
-        elsif($_ eq '>')    { $depth-- if $depth }
-        elsif($_ eq ',' || $_ eq ';')
-        {   warn "Unmatched '<>' in $line" if $depth;
-            my $o = $class->_complete(\@phrase, \@address, \@comment);
-            push @objs, $o if defined $o;
-            $depth = 0;
-            $next = _find_next $idx+1, $tokens, $len;
-        }
-        elsif($depth)       { push @address, $_ }
-        elsif($next eq '<') { push @phrase,  $_ }
-        elsif( /^[.\@:;]$/ || !@address || $address[-1] =~ /^[.\@:;]$/ )
-        {   push @address, $_ }
-        else
-        {   warn "Unmatched '<>' in $line" if $depth;
-            my $o = $class->_complete(\@phrase, \@address, \@comment);
-            push @objs, $o if defined $o;
-            $depth = 0;
-            push @address, $_;
-        }
-    }
-    @objs;
-}
-
-#------------
-
-sub phrase  { shift->set_or_get(0, @_) }
-sub address { shift->set_or_get(1, @_) }
-sub comment { shift->set_or_get(2, @_) }
-
-sub set_or_get($)
-{   my ($self, $i) = (shift, shift);
-    @_ or return $self->[$i];
-
-    my $val = $self->[$i];
-    $self->[$i] = shift if @_;
-    $val;
-}
-
-
-my $atext = '[\-\w !#$%&\'*+/=?^`{|}~]';
-sub format
-{   my @addrs;
-
-    foreach (@_)
-    {   my ($phrase, $email, $comment) = @$_;
-        my @addr;
-
-        if(defined $phrase && length $phrase)
-        {   push @addr
-              , $phrase =~ /^(?:\s*$atext\s*)+$/o ? $phrase
-              : $phrase =~ /(?<!\\)"/             ? $phrase
-              :                                    qq("$phrase");
-
-            push @addr, "<$email>"
-                if defined $email && length $email;
-        }
-        elsif(defined $email && length $email)
-        {   push @addr, $email;
-        }
-
-        if(defined $comment && $comment =~ /\S/)
-        {   $comment =~ s/^\s*\(?/(/;
-            $comment =~ s/\)?\s*$/)/;
-        }
-
-        push @addr, $comment
-            if defined $comment && length $comment;
-
-        push @addrs, join(" ", @addr)
-            if @addr;
-    }
-
-    join ", ", @addrs;
-}
-
-#------------
-
-sub name
-{   my $self   = shift;
-    my $phrase = $self->phrase;
-    my $addr   = $self->address;
-
-    $phrase    = $self->comment
-        unless defined $phrase && length $phrase;
-
-    my $name   = $self->_extract_name($phrase);
-
-    # first.last@domain address
-    if($name eq '' && $addr =~ /([^\%\.\@_]+([\._][^\%\.\@_]+)+)[\@\%]/)
-    {   ($name  = $1) =~ s/[\._]+/ /g;
-	$name   = _extract_name $name;
-    }
-
-    if($name eq '' && $addr =~ m#/g=#i)    # X400 style address
-    {   my ($f) = $addr =~ m#g=([^/]*)#i;
-	my ($l) = $addr =~ m#s=([^/]*)#i;
-	$name   = _extract_name "$f $l";
-    }
-
-    length $name ? $name : undef;
-}
-
-
-sub host
-{   my $addr = shift->address || '';
-    my $i    = rindex $addr, '@';
-    $i >= 0 ? substr($addr, $i+1) : undef;
-}
-
-
-sub user
-{   my $addr = shift->address || '';
-    my $i    = rindex $addr, '@';
-    $i >= 0 ? substr($addr,0,$i) : $addr;
-}
+=head1 NAME
+
+Mail::Address - parse mail addresses
+
+=head1 SYNOPSIS
+
+ use Mail::Address;
+ my @addrs = Mail::Address->parse($line);
+
+ foreach $addr (@addrs) {
+     print $addr->format,"\n";
+ }
+
+=head1 DESCRIPTION
+
+C<Mail::Address> extracts and manipulates email addresses from a message
+header.  It cannot be used to extract addresses from some random text.
+You can use this module to create RFC822 compliant fields.
+
+Although C<Mail::Address> is a very popular subject for books, and is
+used in many applications, it does a very poor job on the more complex
+message fields.  It does only handle simple address formats (which
+covers about 95% of what can be found). Problems are with
+
+=over 4
+
+=item *
+
+no support for address groups, even not with the semi-colon as
+separator between addresses;
+
+=item *
+
+limited support for escapes in phrases and comments.  There are
+cases where it can get wrong; and
+
+=item *
+
+you have to take care of most escaping when you create an address yourself:
+C<Mail::Address> does not do that for you.
+
+=back
+
+Often requests are made to the maintainers of this code improve this
+situation, but this is not a good idea, where it will break zillions
+of existing applications.  If you wish for a fully RFC2822 compliant
+implementation you may take a look at L<Mail::Message::Field::Full>,
+part of MailBox.
+
+B<. Example>
+
+  my $s = Mail::Message::Field::Full->new($from_header);
+  # ref $s isa Mail::Message::Field::Addresses;
+
+  my @g = $s->groups;          # all groups, at least one
+  # ref $g[0] isa Mail::Message::Field::AddrGroup;
+  my $ga = $g[0]->addresses;   # group addresses
+
+  my @a = $s->addresses;       # all addresses
+  # ref $a[0] isa Mail::Message::Field::Address;
+
+=head1 METHODS
+
+=head2 Constructors
+
+=over 4
+
+=item Mail::Address-E<gt>B<new>( $phrase, $address, [ $comment ] )
+
+Create a new C<Mail::Address> object which represents an address with the
+elements given. In a message these 3 elements would be seen like:
+
+ PHRASE <ADDRESS> (COMMENT)
+ ADDRESS (COMMENT)
+
+example: 
+
+ Mail::Address->new("Perl5 Porters", "perl5-porters@africa.nicoh.com");
+
+=item $obj-E<gt>B<parse>($line)
+
+Parse the given line a return a list of extracted C<Mail::Address> objects.
+The line would normally be one taken from a To,Cc or Bcc line in a message
+
+example: 
+
+ my @addr = Mail::Address->parse($line);
+
+=back
+
+=head2 Accessors
+
+=over 4
+
+=item $obj-E<gt>B<address>()
+
+Return the address part of the object.
+
+=item $obj-E<gt>B<comment>()
+
+Return the comment part of the object
+
+=item $obj-E<gt>B<format>(@addresses)
+
+Return a string representing the address in a suitable form to be placed
+on a C<To>, C<Cc>, or C<Bcc> line of a message.  This method is called on
+the first address to be used; other specified addresses will be appended,
+separated by commas.
+
+=item $obj-E<gt>B<phrase>()
+
+Return the phrase part of the object.
+
+=back
+
+=head2 Smart accessors
+
+=over 4
+
+=item $obj-E<gt>B<host>()
+
+Return the address excluding the user id and '@'
+
+=item $obj-E<gt>B<name>()
+
+Using the information contained within the object attempt to identify what
+the person or groups name is.
+
+B<Note:> This function tries to be smart with the "phrase" of the
+email address, which is probably a very bad idea.  Consider to use
+L<phrase()|Mail::Address/"Accessors"> itself.
+
+=item $obj-E<gt>B<user>()
+
+Return the address excluding the '@' and the mail domain
+
+=back
+
+=head1 SEE ALSO
+
+This module is part of the MailTools distribution,
+F<http://perl.overmeer.net/mailtools/>.
+
+=head1 AUTHORS
+
+The MailTools bundle was developed by Graham Barr.  Later, Mark
+Overmeer took over maintenance without commitment to further development.
+
+Mail::Cap by Gisle Aas E<lt>aas@oslonett.noE<gt>.
+Mail::Field::AddrList by Peter Orbaek E<lt>poe@cit.dkE<gt>.
+Mail::Mailer and Mail::Send by Tim Bunce E<lt>Tim.Bunce@ig.co.ukE<gt>.
+For other contributors see ChangeLog.
+
+=head1 LICENSE
+
+Copyrights 1995-2000 Graham Barr E<lt>gbarr@pobox.comE<gt> and
+2001-2017 Mark Overmeer E<lt>perl@overmeer.netE<gt>.
+
+This program is free software; you can redistribute it and/or modify it
+under the same terms as Perl itself.
+See F<http://www.perl.com/perl/misc/Artistic.html>
 
-1;
-- 
2.15.1.424.g9478a66081

