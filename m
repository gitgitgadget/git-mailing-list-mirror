From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 9/9] gitweb: File based caching layer (from git.kernel.org)
Date: Fri, 15 Jan 2010 18:48:59 -0800 (PST)
Message-ID: <m3hbqmdau2.fsf@localhost.localdomain>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 03:49:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVyiu-0003aV-To
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 03:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399Ab0APCtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 21:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758242Ab0APCtF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 21:49:05 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:55124 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758122Ab0APCtD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 21:49:03 -0500
Received: by fxm25 with SMTP id 25so761188fxm.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 18:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=vt6VHharHEwURUqYB74RqYDK3MQxBkcDI5Dp7RLiIcs=;
        b=xcLetUnHR9ynyO51JxmkSrSE+vNroBORHNpxhAIM+ihN6r9sdEVuIuTg4uW/n4On1l
         eCiRl3S8nkq3bmOkh8b0LcageS2SDbP3KQVjNnOCKwDpCXtW/mz81qJwMrZXAEDoOI7C
         aGwtlzDI2bcLG/Lrj6luRS6yfI/tjzd9PXCcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=A1C+KYful9HqbN+h5Gx/G/aKw/4OSL2bXCU+OuSlguKBgFfbdr7U0mrnbLsAbZ/RuQ
         qkhMqf36u5KaSP79pkKH6hypnBOH4G206pG0RRhEbPgoayNOr/i+XCvYayX2Q9UEbpLq
         JJC3Xk6VlVLJCpSMofARr9LNmR6clpu4oo2kg=
Received: by 10.223.2.205 with SMTP id 13mr3521120fak.83.1263610140259;
        Fri, 15 Jan 2010 18:49:00 -0800 (PST)
Received: from localhost.localdomain (abwi123.neoplus.adsl.tpnet.pl [83.8.232.123])
        by mx.google.com with ESMTPS id 1sm3299585fkt.33.2010.01.15.18.48.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 18:48:59 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0G2mMwv001989;
	Sat, 16 Jan 2010 03:48:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0G2m57N001985;
	Sat, 16 Jan 2010 03:48:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137192>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This is a very large patch

This is true, and that is why I am woeking on splitting this patch
into series of smaller patches, each adding single feature present in
this megapatch (this code drop)... and cleaning up (and improving) it
while at it.  This hopefully would make it easier to review.

>                             that implements the file based
> caching layer that is used on such large sites as kernel.org and
> soon git.fedoraproject.org.  This provides a simple, and straight
> forward caching mechanism that scales dramatically better than
> Gitweb by itself.

Do you have any benchmarks comparing gitweb performace with and
without caching enabled?

> 
> The caching layer basically buffers the output that Gitweb would
> normally return, and saves that output to a cache file on the local
> disk.  When the file is requested it attempts to gain a shared lock
> on the cache file and cat it out to the client.  Should an exclusive
> lock be on a file (it's being updated) the code has a choice to either
> update in the background and go ahead and show the stale page while
> update is being performed, or stall the client(s) until the page
> is generated.

The above paragraph is not very clear to me.


Correct me if I am wrong, but as I understand it the cache
architecture is as following:

* This patch implements output caching, which means that the whole
  gitweb response, including HTTP headers, is stored in cache.  (This
  means that in absence of extra mechanism content-type negotiation
  should be disabled when caching is turned on).

* Caching engine used implements simple file based caching layer,
  where cached data is stored verbatim in cache file (no serialization
  / hibernating / marshalling of data - better performance, and
  possibility of X-Sendfile support).  Cache expiration is global
  value, i.e. is not stored along cache entry in file.  Cache entries
  expire based on mtime of file.

* When there exist cache entry for given request, and it is not
  expired, gitweb output is served directtly from cache file.

* When there exist cache entry for given request, but it is expired,
  one process acquires exclusive (writer) lock on file; the rest of
  clients get served stale data.

* When there does not exist cache entry for given request, one process
  acquires exclusive (writer) lock on cache file; the rest of clients
  wait for cache to be filled.

> 
> There are two forms of stalling involved here, background building
> and non-background building, both of which are discussed in the
> configuration page.

I'd like to have at least design decisions put into commit message,
and perhaps also have caching mechanism described in separate section
in gitweb/README.

> 
> There are still a few known "issues" with respect to this:
> - Code needs to be added to be "browser" aware so
>   that clients like wget that are trying to get a
>   binary blob don't obtain a "Generating..." page

This issue should be clearly addressed: when do we serve
"Generating..." page, and when we do not.  The issue is not only wget
trying to download binary blob or patchset, or snapshot, but also
binary blob which is image referenced from a blob which is HTML, and
there is issue of web feeds (accessed by feed readers).

> - There is an intermittent flushing issue that has yet
>   to be tracked down

Could you tell us more where does this shows (what are the
symptompts)?

BTW if it was split into small separate commits, you could be able to
find bug by bisecting history.  Also troubles with finding this bug
might mean that code is not very clean.

> 
> Caching is disabled by default with the $cache_enable variable,
> setting this to 1 will enable file based caching.  It is expected
> that this will be extended to include additional types of caching
> (like memcached) in the future and should not be exclusively
> considered a binary value.

Not a good idea, IMHO.  In my rewrite of this patch there is _boolean_
$caching_enabled variable which controls if (output) caching is
enabled or not, and $cache variable holding instance of cache engine,
which might be used to select different caching that simple file-based
caching.

Signoff?

> ---
>  gitweb/cache.pm    |  283 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  gitweb/gitweb.css  |    6 +
>  gitweb/gitweb.perl |   58 ++++++++++-
>  3 files changed, 344 insertions(+), 3 deletions(-)
>  create mode 100644 gitweb/cache.pm

Very large patch... but no updates to gitweb/README, no updates to
t/gitweb-lib.sh (I guess that gitweb tests are no longer working).
 
> diff --git a/gitweb/cache.pm b/gitweb/cache.pm
> new file mode 100644
> index 0000000..d08bcec
> --- /dev/null
> +++ b/gitweb/cache.pm
> @@ -0,0 +1,283 @@
> +# gitweb - simple web interface to track changes in git repositories
> +#
> +# (C) 2006, John 'Warthog9' Hawley <warthog19@eaglescrag.net>
> +#
> +# This program is licensed under the GPLv2
> +
> +#
> +# Gitweb caching engine
> +#
> +
> +use File::Path qw(make_path remove_tree);

Using make_path (you do not use remove_tree, so there is no need for
importing it) instead of older mkdir interface requires File::Path
version 2.0 (which meant that I had to upgrade File::Path).  This at
least should be mentioned in the comment, perhaps also in
gitweb/INSTALL.

> +use Digest::MD5 qw(md5 md5_hex md5_base64);

You use only md5_hex; no need to import other functions.

> +use Fcntl ':flock';
> +
> +sub cache_fetch {
> +	my ($action) = @_;
> +	my $cacheTime = 0;
> +
> +	# Deal with cache being disabled
> +	if( $cache_enable == 0 ){

Style:

  +	if ($cache_enable == 0) {

or better

  +	if ($cache_enabled) {

> +		$output_handler = *STDOUT;
> +		$output_handler_bin = *STDOUT;

There should be no need for that, as $output_handle is set to *STDOUT
(or \*STDOUT) anyway.

> +		$actions{$action}->();
> +		return;

Anyway I think that the whole block should be _outside_ cache_fetch,
which should be invoked only if caching is enabled.  For example in
gitweb.perl:

  if ($caching_enabled) {
  	do $cache_pm;
  	die $@ if $@;
  
  	# ...
  
	cache_fetch($cache, $action);
  } else {
  	$actions{$action}->();
  }

> +	}elsif( $cache_enable == 1 ){

Style.

> +		#obviously we are using file based caching

See my comment about using $cache_enable as enum selecting cache type
(blergh).  BTW what's with 'obviously'?

> +
> +		if(! -d $cachedir){

Style.

> +			print "*** Warning ***: Caching enabled but cache directory does not exsist.  ($cachedir)\n";

Why this warning?  Is it really necessary?

> +			mkdir ("cache", 0665) || die "Cannot create cache dir - you will need to manually create";
> +			print "Cache directory created successfully\n";
> +		}
> +
> +		our $full_url = "$my_url?". $ENV{'QUERY_STRING'};

Wouldn't work if you client uses path_info URL, e.g.

  http://repo.or.cz/w/git/jnareb-git.git/shortlog/refs/heads/gitweb/cache-kernel

That's why I use href(-replay=>1, -full_url=>1, -path_info=>0) for
cache key for request (you could use freeze(\%input_params) instead,
where freeze is from Storable module).

> +		our $urlhash = md5_hex($full_url);
> +		our $fullhashdir = "$cachedir/". substr( $urlhash, 0, 2) ."/";

Is depth 2 enough for cache?

> +
> +		my $numdirs = make_path( $fullhashdir, { mode => 0777, error => \my $mkdirerr, } );
> +		if( @$mkdirerr ){
> +			my $mkdirerrmsg = "";
> +			for my $diag (@$mkdirerr) {
> +				my ($file, $message) = %$diag;
> +				if($file eq '' ){
> +					$mkdirerrmsg .= "general error: $message\n";
> +				}else{
> +					$mkdirerrmsg .= "problem unlinking $file: $message\n";
> +				}
> +			}
> +			die_error(500, "Could not create cache directory | $mkdirerrmsg");
> +		}
> +		$fullhashpath = "$fullhashdir/". substr( $urlhash, 2 );
> +		$fullhashbinpath = "$fullhashpath.bin";
> +	} # done dealing with cache enabled / disabled

Note also if dealing with caching enabled / disabled was outside
cache_fetch you would have less nested code.

> +
> +	if(! -e "$fullhashpath" ){
> +		if(! defined(my $childPid = fork()) ){

Style.

> +			cacheUpdate($action,0);
> +			cacheDisplay($action);

Why camelCase Java/JavaScript-like convention, quite different from
the C-like naming convention used elsewhere in gitweb?

> +		} elsif ( $childPid == 0 ){
> +			#run the updater
> +			cacheUpdate($action,1);

cacheUpdate($action,0) vs cacheUpdate($action,1) is very cryptic
distinctions.  It would be better to use "named parameter" and/or
separate, differently named, [wrapper] functions.

> +		}else{
> +			cacheWaitForUpdate($action);
> +		}

This whole block should probably be in a separate function.

> +	}else{
> +		#if cache is out dated, update
> +		#else displayCache();
> +		open(cacheFile, '<', "$fullhashpath");
> +		stat(cacheFile);
> +		close(cacheFile);

You don't need to open file to stat it.

> +		$cacheTime = get_loadavg() * 60;
> +		if( $cacheTime > $maxCacheTime ){
> +			$cacheTime = $maxCacheTime;
> +		}
> +		if( $cacheTime < $minCacheTime ){
> +			$cacheTime = $minCacheTime;
> +		}

This should probably be a separate function (effective cache expiraton
time).  Also adaptiveness of caching is not described in commit
message.

> +		if( (stat(_))[9] < (time - $cacheTime) ){
> +			if( ! defined(my $childPid = fork()) ){
> +				cacheUpdate($action,0);
> +				cacheDisplay($action);
> +			} elsif ( $childPid == 0 ){
> +				#run the updater
> +				#print "Running updater\n";

Remains of debugging.

> +				cacheUpdate($action,1);
> +			}else{
> +				#print "Waiting for update\n";
> +				cacheWaitForUpdate($action);
> +			}

Repeated code (I think).

> +		} else {
> +			cacheDisplay($action);
> +		}
> +
> +
> +	}
> +
> +	#
> +	# If all of the caching failes - lets go ahead and press on without it and fall back to 'default'
> +	# non-caching behavior.  This is the softest of the failure conditions.
> +	#
> +	#$actions{$action}->();

Why is this commented out?

> +}
> +
> +sub cacheUpdate {
> +	my ($action,$areForked) = @_;
> +	my $lockingStatus;
> +	my $fileData = "";
> +
> +	if($backgroundCache){
> +		open(cacheFileBG, '>:utf8', "$fullhashpath.bg");
> +		my $lockStatBG = flock(cacheFileBG,LOCK_EX|LOCK_NB);
> +
> +		$lockStatus = $lockStatBG;
> +	}else{
> +		open(cacheFile, '>:utf8', "$fullhashpath");
> +		my $lockStat = flock(cacheFile,LOCK_EX|LOCK_NB);
> +
> +		$lockStatus = $lockStat;
> +	}

Almost identical code.  Use of global handles instead of indirect
filehandles.

> +	#print "lock status: $lockStat\n";
> +
> +
> +	if (! $lockStatus ){
> +		if ( $areForked ){
> +			exit(0);
> +		}else{
> +			return;
> +		}
> +	}

This conditional needs explanation (comment), I think.

> +
> +	if(
> +		$action eq "snapshot"
> +		||
> +		$action eq "blob_plain"

This condition should be put in a separate function/

> +	){
> +		open cacheFileBin, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
> +		$output_handler_bin = *cacheFileBin;
> +	}
> +
> +	$output_handler = *cacheFile;
> +
> +	if($backgroundCache){
> +		open(cacheFile, '>:utf8', "$fullhashpath");

Why "$fullhashpath" and not simply $fullhashpath?

> +		$lockStat = flock(cacheFile,LOCK_EX);
> +
> +		if (! $lockStat ){
> +			if ( $areForked ){
> +				exit(0);
> +			}else{
> +				return;
> +			}
> +		}

Repeated code.

> +	}
> +
> +	$actions{$action}->();
> +
> +	if(
> +		$action eq "snapshot"
> +		||
> +		$action eq "blob_plain"
> +	){
> +		close(cacheFileBin);
> +	}
> +
> +	flock(cacheFile,LOCK_UN);
> +	close(cacheFile);
> +
> +	if($backgroundCache){
> +		flock(cacheFileBG,LOCK_UN);
> +		close(cacheFileBG);
> +	}
> +
> +	if ( $areForked ){
> +		exit(0);
> +	} else {
> +		return;
> +	}
> +}
> +
> +
> +sub cacheWaitForUpdate {
> +	my ($action) = @_;
> +	my $x = 0;
> +	my $max = 10;

What is $x, what is $max?

> +	my $lockStat = 0;
> +
> +	if( $backgroundCache ){
> +		if( -e "$fullhashpath" ){
> +			open(cacheFile, '<:utf8', "$fullhashpath");

Why opening with :uft8, and not with :raw?  I don't think we need to
do the eventual conversion once again...

> +			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
> +			stat(cacheFile);
> +			close(cacheFile);
> +
> +			if( $lockStat && ( (stat(_))[9] > (time - $maxCacheLife) ) ){
> +				cacheDisplay($action);
> +				return;
> +			}

Why do we deal with cache expiration in two places?  If it is not
a bug, it should be explained in a comment.

> +		}
> +	}
> +
> +	if(
> +		$action eq "atom"
> +		||
> +		$action eq "rss"
> +		||
> +		$action eq "opml"
> +	){
> +		do {
> +			sleep 2 if $x > 0;
> +			open(cacheFile, '<:utf8', "$fullhashpath");
> +			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
> +			close(cacheFile);
> +			$x++;
> +			$combinedLockStat = $lockStat;
> +		} while ((! $combinedLockStat) && ($x < $max));

Why busy wait instead of _blocking_ lock, i.e. waiting on lock for it
to be free?  It doesn't look like we _do_ anything in the loop.

Ah, I see that we wait at most 2*$max seconds (where interval of 2
seconds is hardcoded).  Is it really necessary?

> +
> +		if( $x != $max ){
> +			cacheDisplay($action);
> +		}
> +		return;
> +	}
> +
> +	$| = 1;
> +
> +	print $::cgi->header(-type=>'text/html', -charset => 'utf-8',
> +	                   -status=> 200, -expires => 'never');
> +
> +	print <<EOF;
> +<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/TR/html4/strict.dtd">
> +<!-- git web w/caching interface version $version, (C) 2006-2010, John 'Warthog9' Hawley <warthog9\@kernel.org> -->
> +<!-- git core binaries version $git_version -->
> +<head>
> +<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
> +<meta name="generator" content="gitweb/$version git/$git_version"/>
> +<meta name="robots" content="index, nofollow"/>
> +<meta http-equiv="refresh" content="0"/>
> +<title>$title</title>
> +</head>
> +<body>
> +EOF
> +
> +	print "Generating..";
> +	do {
> +		print ".";
> +		sleep 2 if $x > 0;
> +		open(cacheFile, '<:utf8', "$fullhashpath");
> +		$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
> +		close(cacheFile);
> +		$x++;
> +		$combinedLockStat = $lockStat;
> +	} while ((! $combinedLockStat) && ($x < $max));

This trick of having http-equiv 'refresh' meta with the delay of 0
seconds, but not closing the output and therefore not triggering
redirect should be described in comments, and perhaps also in the
commit message.

> +	print <<EOF;
> +</body>
> +</html>
> +EOF
> +	return;
> +}
> +
> +sub cacheDisplay {
> +	my ($action) = @_;
> +	open(cacheFile, '<:utf8', "$fullhashpath");
> +	$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
> +	if (! $lockStat ){
> +		close(cacheFile);
> +		cacheWaitForUpdate($action);
> +	}
> +
> +	while( <cacheFile> ){
> +		print $_;
> +	}

Why not slurp it (local $/ = undef), but write line after line?

> +	if(
> +		$action eq "snapshot"
> +		||
> +		$action eq "blob_plain"
> +	){
> +		open(cacheFileBin, '<', "$fullhashbinpath");
> +		binmode STDOUT, ':raw';
> +		print <cacheFileBin>;

Why not slurp it (local $/ = undef), but write line after line,
implicitly?

> +		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
> +		close(cacheFileBin);
> +	}
> +	close(cacheFile);
> +}

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8bb323c..ec95bb9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -230,6 +230,50 @@ our $git_versions_must_match = 1;
>  # Leave it undefined (or set to 'undef') to turn off load checking.
>  our $maxload = 300;
>  
> +# This enables/disables the caching layer in gitweb.  This currently only supports the
> +# 'dumb' file based caching layer, primarily used on git.kernel.org.  this is reasonably
> +# effective but it has the downside of requiring a huge amount of disk space if there
> +# are a number of repositories involved.  It is not uncommon for git.kernel.org to have
> +# on the order of 80G - 120G accumulate over the course of a few months.  It is recommended
> +# that the cache directory be periodically completely deleted, and this is safe to perform.
> +# Suggested mechanism
> +# mv $cacheidr $cachedir.flush;mkdir $cachedir;rm -rf $cachedir.flush
> +# Value is binary. 0 = disabled (default), 1 = enabled.
> +#
> +# Values of caching:
> +# 	1 = 'dumb' file based caching used on git.kernel.org
> +our $cache_enable = 0;
> +
> +# Used to set the minimum cache timeout for the dynamic caching algorithm.  Basically
> +# if we calculate the cache to be under this number of seconds we set the cache timeout
> +# to this minimum.
> +# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
> +our $minCacheTime = 20;
> +
> +# Used to set the maximum cache timeout for the dynamic caching algorithm.  Basically
> +# if we calculate the cache to exceed this number of seconds we set the cache timeout
> +# to this maximum.
> +# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
> +our $maxCacheTime = 1200;
> +
> +# If you need to change the location of the caching directory, override this
> +# otherwise this will probably do fine for you
> +our $cachedir = 'cache';

Why not '/tmp/gitweb-cache', or '/var/cache/gitweb'?  Perhaps use
TMPDIR / File::Spec->tmpdir() if it is undefined?

Note that this path is relative to the place where we run gitweb from,
which is important for gitweb tests.

> +
> +# If this is set (to 1) cache will do it's best to always display something instead
> +# of making someone wait for the cache to update.  This will launch the cacheUpdate
> +# into the background and it will lock a <file>.bg file and will only lock the
> +# actual cache file when it needs to write into it.  In theory this will make
> +# gitweb seem more responsive at the price of possibly stale data.
> +our $backgroundCache = 1;

Does it mean that if there exist cache entry for given request, but it
is expired, also the client that created write lock gets stale data
instead of 'Generating...' info, and updates/regenerates cache using
background process?

This comment is not entirely clear for me.

> +
> +# Used to set the maximum cache file life.  If a cache files last modify time exceeds
> +# this value, it will assume that the data is just too old, and HAS to be regenerated
> +# instead of trying to display the existing cache data.
> +# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
> +# 18000 = 5 hours
> +our $maxCacheLife = 18000;

This should also be mentioned in commit message (modifying what I
wrote).

> +
>  # You define site-wide feature defaults here; override them with
>  # $GITWEB_CONFIG as necessary.
>  our %feature = (
> @@ -593,6 +637,11 @@ if (defined $maxload && get_loadavg() > $maxload) {
>  	die_error(503, "The load average on the server is too high");
>  }
>  
> +#
> +# Includes
> +#
> +do 'cache.pm';

Should be

  +do "$cache_pm";

if you don't use require, where $cache_pm can be overriden in gitweb
config, otherwise gitweb caching tests wouldn't work: they invoke
gitweb from test directory.

> +
>  # version of the core git binary
>  our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
>  $number_of_git_cmds++;
> @@ -994,7 +1043,7 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
>      !$project) {
>  	die_error(400, "Project needed");
>  }
> -$actions{$action}->();
> +cache_fetch($action);
>  exit;
>  

As I wrote, I think cache_fetch should be invoked only when caching is
enabled.

>  ## ======================================================================
> @@ -3200,7 +3249,9 @@ sub git_header_html {
>  	# support xhtml+xml but choking when it gets what it asked for.
>  	if (defined $cgi->http('HTTP_ACCEPT') &&
>  	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
> -	    $cgi->Accept('application/xhtml+xml') != 0) {
> +	    $cgi->Accept('application/xhtml+xml') != 0
> +	    &&
> +	    $cache_enable == 0) {
>  		$content_type = 'application/xhtml+xml';
>  	} else {
>  		$content_type = 'text/html';

O.K.

> @@ -3344,6 +3395,7 @@ sub git_footer_html {
>  	my $feed_class = 'rss_logo';
>  
>  	print {$output_handler} "<div class=\"page_footer\">\n";
> +	print {$output_handler} "<div class=\"cachetime\">Cache Last Updated: ". gmtime( time ) ." GMT</div>\n";

Shouldn't this be conditional on $cache_enabled?

>  	if (defined $project) {
>  		my $descr = git_get_project_description($project);
>  		if (defined $descr) {

BTW. you need, I think, protect timing info and do not show it if
caching is enabled.  It doesn't make much sense to show how much time
it took to generate page... when said page could have been retrieved
from cache.

But it might make sense; I am not sure.

> @@ -3424,7 +3476,7 @@ sub die_error {
>  	my $extra = shift;
>  
>  	# The output handlers for die_error need to be reset to STDOUT
> -	# so that half the message isn't being output to random and 
> +	# so that half the message isn't being output to random and
>  	# half to STDOUT as expected.  This is mainly for the benefit
>  	# of using git_header_html() and git_footer_html() since those
>  	# internaly use the indirect print handler.

It looks like spurious change.

> -- 
> 1.6.5.2
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
