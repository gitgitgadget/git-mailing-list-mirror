Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6759C1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeCCPjS (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:18 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35620 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbeCCPjO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:14 -0500
Received: by mail-wr0-f177.google.com with SMTP id l43so12994865wrc.2
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1ci+xGpOKhxYnyS+KjNjEXUx63l3kMOcC/Dka9MrsbM=;
        b=kJLg+04A+FOevXisDHtQiPqmnt8/okQqlnUjX0Qj7pyz+DVQICa4Ui8IneZ56e0XDM
         IdwYQYhlDXyGYR1tBKDa7OI0tFZbqFY5PZsvp3pf+nP2GXwkCvd+BsSkWhfJFvPhospY
         nsqaolcUvAlFUyHYD0/ce5CSQ/6dQukPj/74ur1+IvTJwqkAh+hUS7HiyCKaj1dCY5Z0
         zrLh19BoPXaGngzj1ugI7j78xJI7xJkG1/NmmQ1AVrt/QHVNW/rHG1vokXrgTiLz06cd
         vaUvX5x23NnNhDlCQ0evPoCh7EIdE9db/EWZqkhMpubtj8A2B/9LLPiZ3y0EL1tu6xGd
         /BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1ci+xGpOKhxYnyS+KjNjEXUx63l3kMOcC/Dka9MrsbM=;
        b=jmibugl6tu6ObIZiNMRtZ1sNLN+oNDRQ1BlisSIEXAI3XMeAs6RvNQkCH3c9EfUJgw
         zk24opor0gQST3MP3xtox+VAA8z+RD0lm4+nhSoInuaOIIeaXYRLv6NKZ3r+E9zZgX4B
         fsBtBUZPcPaa47Xc/ZgSr+L+v6HLrdutwGyZI8HUJn+jsep743rIE174ZqQirGv4lur6
         JxCq3EyYUK9XxUcBaQIMzdxXowZHkNRJBhmYQ1Gl9Tp7MKRq4b+vTQ2bOjGZjZy0Pj1o
         5UgdbEsWcpLJf8faNsDmyq4Z1amtn5tiUKxhLh6clACJ+xQWwhoiv7HYHJzsug0j6tMz
         h4Zg==
X-Gm-Message-State: APf1xPBC5agHfo7T51nrzrsTRbYkdNMwvobu3NNllg5PkNY9flnMdrAg
        gkfQW8Ro7puD9jc8LOCJrQqqzaLj
X-Google-Smtp-Source: AG47ELs/rdOzmiRC5SyBWjKFzPPTGEmXTAlTTLmDevRndVLOSvZJL54CfVehXl/GaEmAKdmw4UAJIQ==
X-Received: by 10.223.154.49 with SMTP id z46mr7765700wrb.143.1520091552534;
        Sat, 03 Mar 2018 07:39:12 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/13] perl: update our ancient copy of Error.pm
Date:   Sat,  3 Mar 2018 15:38:11 +0000
Message-Id: <20180303153817.20270-8-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180303153817.20270-1-avarab@gmail.com>
References: <20180303153817.20270-1-avarab@gmail.com>
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Error.pm shipped with Git as a fallback if there was no Error.pm
on the system was released in April 2006. There's been dozens of
releases since then, the latest at August 7, 2017. Let's update to
that.

I don't know of anything we need from this new release or which this
fixes. This change is simply a matter of keeping up with
upstream. Before this users who'd install git via their package system
would get an up-to-date Error.pm, but if it's installed from source
they'd get one more than a decade old.

This undoes a local hack we'd accumulated in 96bc4de85c ("Eliminate
Scalar::Util usage from private-Error.pm", 2006-07-26), it's been
redundant since my d48b284183 ("perl: bump the required Perl version
to 5.8 from 5.6.[21]", 2010-09-24).

This also undoes 3a51467b94 ("Typo fix: replacing it's -> its",
2013-04-13). This is the Nth time I find that some upstream code of
ours (in contrib/, in sha1dc/ and now in perl/ ...) has diverged from
upstream because of some tree-wide typo fixing. Let's not do those
fixes against upstream projects, it's more valuable that we have a 1=1
mapping to upstream than to fix typos in docs we never even generate
from this code. If someone wants to fix typos in them fine, but they
should do it with a patch to upstream which git.git can then
incorporate.

The upstream code doesn't cleanly pass a --check, so I'm adding a
.gitattributes file for similar reasons as done for sha1dc in
5d184f468e ("sha1dc: ignore indent-with-non-tab whitespace
violations", 2017-06-06).

The updated source was retrieved from
https://fastapi.metacpan.org/source/SHLOMIF/Error-0.17025/lib/Error.pm

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git/FromCPAN/.gitattributes |   1 +
 perl/Git/FromCPAN/Error.pm       | 296 +++++++++++++++++++++++++++++++++------
 2 files changed, 256 insertions(+), 41 deletions(-)
 create mode 100644 perl/Git/FromCPAN/.gitattributes

diff --git a/perl/Git/FromCPAN/.gitattributes b/perl/Git/FromCPAN/.gitattributes
new file mode 100644
index 0000000000..8b64fc5e22
--- /dev/null
+++ b/perl/Git/FromCPAN/.gitattributes
@@ -0,0 +1 @@
+/Error.pm whitespace=-blank-at-eof
diff --git a/perl/Git/FromCPAN/Error.pm b/perl/Git/FromCPAN/Error.pm
index 6098135ae2..f9c36e9e98 100644
--- a/perl/Git/FromCPAN/Error.pm
+++ b/perl/Git/FromCPAN/Error.pm
@@ -12,10 +12,12 @@
 package Error;
 
 use strict;
+use warnings;
+
 use vars qw($VERSION);
 use 5.004;
 
-$VERSION = "0.15009";
+$VERSION = "0.17025";
 
 use overload (
 	'""'	   =>	'stringify',
@@ -32,21 +34,35 @@ $Error::THROWN = undef;	# last error thrown, a workaround until die $ref works
 my $LAST;		# Last error created
 my %ERROR;		# Last error associated with package
 
-sub throw_Error_Simple
+sub _throw_Error_Simple
 {
     my $args = shift;
     return Error::Simple->new($args->{'text'});
 }
 
-$Error::ObjectifyCallback = \&throw_Error_Simple;
+$Error::ObjectifyCallback = \&_throw_Error_Simple;
 
 
 # Exported subs are defined in Error::subs
 
+use Scalar::Util ();
+
 sub import {
     shift;
+    my @tags = @_;
     local $Exporter::ExportLevel = $Exporter::ExportLevel + 1;
-    Error::subs->import(@_);
+
+    @tags = grep {
+       if( $_ eq ':warndie' ) {
+          Error::WarnDie->import();
+          0;
+       }
+       else {
+          1;
+       }
+    } @tags;
+
+    Error::subs->import(@tags);
 }
 
 # I really want to use last for the name of this method, but it is a keyword
@@ -107,10 +123,6 @@ sub stacktrace {
     $text;
 }
 
-# Allow error propagation, ie
-#
-# $ber->encode(...) or
-#    return Error->prior($ber)->associate($ldap);
 
 sub associate {
     my $err = shift;
@@ -130,6 +142,7 @@ sub associate {
     return;
 }
 
+
 sub new {
     my $self = shift;
     my($pkg,$file,$line) = caller($Error::Depth);
@@ -246,6 +259,10 @@ sub value {
 
 package Error::Simple;
 
+use vars qw($VERSION);
+
+$VERSION = "0.17025";
+
 @Error::Simple::ISA = qw(Error);
 
 sub new {
@@ -288,14 +305,6 @@ use vars qw(@EXPORT_OK @ISA %EXPORT_TAGS);
 
 @ISA = qw(Exporter);
 
-
-sub blessed {
-	my $item = shift;
-	local $@; # don't kill an outer $@
-	ref $item and eval { $item->can('can') };
-}
-
-
 sub run_clauses ($$$\@) {
     my($clauses,$err,$wantarray,$result) = @_;
     my $code = undef;
@@ -314,16 +323,17 @@ sub run_clauses ($$$\@) {
 		my $pkg = $catch->[$i];
 		unless(defined $pkg) {
 		    #except
-		    splice(@$catch,$i,2,$catch->[$i+1]->());
+		    splice(@$catch,$i,2,$catch->[$i+1]->($err));
 		    $i -= 2;
 		    next CATCHLOOP;
 		}
-		elsif(blessed($err) && $err->isa($pkg)) {
+		elsif(Scalar::Util::blessed($err) && $err->isa($pkg)) {
 		    $code = $catch->[$i+1];
 		    while(1) {
 			my $more = 0;
-			local($Error::THROWN);
+			local($Error::THROWN, $@);
 			my $ok = eval {
+			    $@ = $err;
 			    if($wantarray) {
 				@{$result} = $code->($err,\$more);
 			    }
@@ -341,10 +351,9 @@ sub run_clauses ($$$\@) {
 			    undef $err;
 			}
 			else {
-			    $err = defined($Error::THROWN)
-				    ? $Error::THROWN : $@;
-                $err = $Error::ObjectifyCallback->({'text' =>$err})
-                    unless ref($err);
+			    $err = $@ || $Error::THROWN;
+				$err = $Error::ObjectifyCallback->({'text' =>$err})
+					unless ref($err);
 			}
 			last CATCH;
 		    };
@@ -357,7 +366,9 @@ sub run_clauses ($$$\@) {
 	if(defined($owise = $clauses->{'otherwise'})) {
 	    my $code = $clauses->{'otherwise'};
 	    my $more = 0;
+        local($Error::THROWN, $@);
 	    my $ok = eval {
+		$@ = $err;
 		if($wantarray) {
 		    @{$result} = $code->($err,\$more);
 		}
@@ -374,11 +385,10 @@ sub run_clauses ($$$\@) {
 		undef $err;
 	    }
 	    else {
-		$err = defined($Error::THROWN)
-			? $Error::THROWN : $@;
+		$err = $@ || $Error::THROWN;
 
-        $err = $Error::ObjectifyCallback->({'text' =>$err})
-            unless ref($err);
+		$err = $Error::ObjectifyCallback->({'text' =>$err})
+			unless ref($err);
 	    }
 	}
     }
@@ -398,7 +408,7 @@ sub try (&;$) {
 
     do {
 	local $Error::THROWN = undef;
-    local $@ = undef;
+	local $@ = undef;
 
 	$ok = eval {
 	    if($wantarray) {
@@ -413,21 +423,21 @@ sub try (&;$) {
 	    1;
 	};
 
-	$err = defined($Error::THROWN) ? $Error::THROWN : $@
+	$err = $@ || $Error::THROWN
 	    unless $ok;
     };
 
     shift @Error::STACK;
 
     $err = run_clauses($clauses,$err,wantarray,@result)
-	unless($ok);
+    unless($ok);
 
     $clauses->{'finally'}->()
 	if(defined($clauses->{'finally'}));
 
     if (defined($err))
     {
-        if (blessed($err) && $err->can('throw'))
+        if (Scalar::Util::blessed($err) && $err->can('throw'))
         {
             throw $err;
         }
@@ -506,12 +516,116 @@ sub otherwise (&;$) {
 }
 
 1;
+
+package Error::WarnDie;
+
+sub gen_callstack($)
+{
+    my ( $start ) = @_;
+
+    require Carp;
+    local $Carp::CarpLevel = $start;
+    my $trace = Carp::longmess("");
+    # Remove try calls from the trace
+    $trace =~ s/(\n\s+\S+__ANON__[^\n]+)?\n\s+eval[^\n]+\n\s+Error::subs::try[^\n]+(?=\n)//sog;
+    $trace =~ s/(\n\s+\S+__ANON__[^\n]+)?\n\s+eval[^\n]+\n\s+Error::subs::run_clauses[^\n]+\n\s+Error::subs::try[^\n]+(?=\n)//sog;
+    my @callstack = split( m/\n/, $trace );
+    return @callstack;
+}
+
+my $old_DIE;
+my $old_WARN;
+
+sub DEATH
+{
+    my ( $e ) = @_;
+
+    local $SIG{__DIE__} = $old_DIE if( defined $old_DIE );
+
+    die @_ if $^S;
+
+    my ( $etype, $message, $location, @callstack );
+    if ( ref($e) && $e->isa( "Error" ) ) {
+        $etype = "exception of type " . ref( $e );
+        $message = $e->text;
+        $location = $e->file . ":" . $e->line;
+        @callstack = split( m/\n/, $e->stacktrace );
+    }
+    else {
+        # Don't apply subsequent layer of message formatting
+        die $e if( $e =~ m/^\nUnhandled perl error caught at toplevel:\n\n/ );
+        $etype = "perl error";
+        my $stackdepth = 0;
+        while( caller( $stackdepth ) =~ m/^Error(?:$|::)/ ) {
+            $stackdepth++
+        }
+
+        @callstack = gen_callstack( $stackdepth + 1 );
+
+        $message = "$e";
+        chomp $message;
+
+        if ( $message =~ s/ at (.*?) line (\d+)\.$// ) {
+            $location = $1 . ":" . $2;
+        }
+        else {
+            my @caller = caller( $stackdepth );
+            $location = $caller[1] . ":" . $caller[2];
+        }
+    }
+
+    shift @callstack;
+    # Do it this way in case there are no elements; we don't print a spurious \n
+    my $callstack = join( "", map { "$_\n"} @callstack );
+
+    die "\nUnhandled $etype caught at toplevel:\n\n  $message\n\nThrown from: $location\n\nFull stack trace:\n\n$callstack\n";
+}
+
+sub TAXES
+{
+    my ( $message ) = @_;
+
+    local $SIG{__WARN__} = $old_WARN if( defined $old_WARN );
+
+    $message =~ s/ at .*? line \d+\.$//;
+    chomp $message;
+
+    my @callstack = gen_callstack( 1 );
+    my $location = shift @callstack;
+
+    # $location already starts in a leading space
+    $message .= $location;
+
+    # Do it this way in case there are no elements; we don't print a spurious \n
+    my $callstack = join( "", map { "$_\n"} @callstack );
+
+    warn "$message:\n$callstack";
+}
+
+sub import
+{
+    $old_DIE  = $SIG{__DIE__};
+    $old_WARN = $SIG{__WARN__};
+
+    $SIG{__DIE__}  = \&DEATH;
+    $SIG{__WARN__} = \&TAXES;
+}
+
+1;
+
 __END__
 
 =head1 NAME
 
 Error - Error/exception handling in an OO-ish way
 
+=head1 WARNING
+
+Using the "Error" module is B<no longer recommended> due to the black-magical
+nature of its syntactic sugar, which often tends to break. Its maintainers
+have stopped actively writing code that uses it, and discourage people
+from doing so. See the "SEE ALSO" section below for better recommendations.
+
 =head1 SYNOPSIS
 
     use Error qw(:try);
@@ -529,7 +643,7 @@ Error - Error/exception handling in an OO-ish way
     try {
 	do_some_stuff();
 	die "error!" if $condition;
-	throw Error::Simple -text => "Oops!" if $other_condition;
+	throw Error::Simple "Oops!" if $other_condition;
     }
     catch Error::IO with {
 	my $E = shift;
@@ -587,7 +701,7 @@ C<BLOCK> will be passed two arguments. The first will be the error
 being thrown. The second is a reference to a scalar variable. If this
 variable is set by the catch block then, on return from the catch
 block, try will continue processing as if the catch block was never
-found.
+found. The error will also be available in C<$@>.
 
 To propagate the error the catch block may call C<$err-E<gt>throw>
 
@@ -608,7 +722,7 @@ type.
 Catch any error by executing the code in C<BLOCK>
 
 When evaluated C<BLOCK> will be passed one argument, which will be the
-error being processed.
+error being processed. The error will also be available in C<$@>.
 
 Only one otherwise block may be specified per try block
 
@@ -625,12 +739,25 @@ Only one finally block may be specified per try block
 
 =back
 
+=head1 COMPATIBILITY
+
+L<Moose> exports a keyword called C<with> which clashes with Error's. This
+example returns a prototype mismatch error:
+
+    package MyTest;
+
+    use warnings;
+    use Moose;
+    use Error qw(:try);
+
+(Thanks to C<maik.hentsche@amd.com> for the report.).
+
 =head1 CLASS INTERFACE
 
 =head2 CONSTRUCTORS
 
 The C<Error> object is implemented as a HASH. This HASH is initialized
-with the arguments that are passed to its constructor. The elements
+with the arguments that are passed to it's constructor. The elements
 that are used by, or are retrievable by the C<Error> class are listed
 below, other classes may add to these.
 
@@ -655,6 +782,10 @@ an object blessed into that package as the C<-object> argument.
 
 =over 4
 
+=item Error->new()
+
+See the Error::Simple documentation.
+
 =item throw ( [ ARGS ] )
 
 Create a new C<Error> object and throw an error, which will be caught
@@ -730,6 +861,13 @@ The line where the constructor of this error was called from
 
 The text of the error
 
+=item $err->associate($obj)
+
+Associates an error with an object to allow error propagation. I.e:
+
+    $ber->encode(...) or
+        return Error->prior($ber)->associate($ldap);
+
 =back
 
 =head2 OVERLOAD METHODS
@@ -759,11 +897,9 @@ to the constructor.
 
 =head1 PRE-DEFINED ERROR CLASSES
 
-=over 4
-
-=item Error::Simple
+=head2 Error::Simple
 
-This class can be used to hold simple error strings and values. Its
+This class can be used to hold simple error strings and values. It's
 constructor takes two arguments. The first is a text value, the second
 is a numeric value. These values are what will be returned by the
 overload methods.
@@ -775,7 +911,6 @@ of the error object.
 This class is used internally if an eval'd block die's with an error
 that is a plain string. (Unless C<$Error::ObjectifyCallback> is modified)
 
-=back
 
 =head1 $Error::ObjectifyCallback
 
@@ -804,6 +939,76 @@ class MyError::Bar by default:
         # Error handling here.
     }
 
+=cut
+
+=head1 MESSAGE HANDLERS
+
+C<Error> also provides handlers to extend the output of the C<warn()> perl
+function, and to handle the printing of a thrown C<Error> that is not caught
+or otherwise handled. These are not installed by default, but are requested
+using the C<:warndie> tag in the C<use> line.
+
+ use Error qw( :warndie );
+
+These new error handlers are installed in C<$SIG{__WARN__}> and
+C<$SIG{__DIE__}>. If these handlers are already defined when the tag is
+imported, the old values are stored, and used during the new code. Thus, to
+arrange for custom handling of warnings and errors, you will need to perform
+something like the following:
+
+ BEGIN {
+   $SIG{__WARN__} = sub {
+     print STDERR "My special warning handler: $_[0]"
+   };
+ }
+
+ use Error qw( :warndie );
+
+Note that setting C<$SIG{__WARN__}> after the C<:warndie> tag has been
+imported will overwrite the handler that C<Error> provides. If this cannot be
+avoided, then the tag can be explicitly C<import>ed later
+
+ use Error;
+
+ $SIG{__WARN__} = ...;
+
+ import Error qw( :warndie );
+
+=head2 EXAMPLE
+
+The C<__DIE__> handler turns messages such as
+
+ Can't call method "foo" on an undefined value at examples/warndie.pl line 16.
+
+into
+
+ Unhandled perl error caught at toplevel:
+
+   Can't call method "foo" on an undefined value
+
+ Thrown from: examples/warndie.pl:16
+
+ Full stack trace:
+
+         main::inner('undef') called at examples/warndie.pl line 20
+         main::outer('undef') called at examples/warndie.pl line 23
+
+=cut
+
+=head1 SEE ALSO
+
+See L<Exception::Class> for a different module providing Object-Oriented
+exception handling, along with a convenient syntax for declaring hierarchies
+for them. It doesn't provide Error's syntactic sugar of C<try { ... }>,
+C<catch { ... }>, etc. which may be a good thing or a bad thing based
+on what you want. (Because Error's syntactic sugar tends to break.)
+
+L<Error::Exception> aims to combine L<Error> and L<Exception::Class>
+"with correct stringification".
+
+L<TryCatch> and L<Try::Tiny> are similar in concept to Error.pm only providing
+a syntax that hopefully breaks less.
+
 =head1 KNOWN BUGS
 
 None, but that does not mean there are not any.
@@ -816,12 +1021,21 @@ The code that inspired me to write this was originally written by
 Peter Seibel <peter@weblogic.com> and adapted by Jesse Glick
 <jglick@sig.bsh.com>.
 
+C<:warndie> handlers added by Paul Evans <leonerd@leonerd.org.uk>
+
 =head1 MAINTAINER
 
-Shlomi Fish <shlomif@iglu.org.il>
+Shlomi Fish, L<http://www.shlomifish.org/> .
 
 =head1 PAST MAINTAINERS
 
 Arun Kumar U <u_arunkumar@yahoo.com>
 
+=head1 COPYRIGHT
+
+Copyright (c) 1997-8  Graham Barr. All rights reserved.
+This program is free software; you can redistribute it and/or modify it
+under the same terms as Perl itself.
+
 =cut
+
-- 
2.15.1.424.g9478a66081

