From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 00/10] gitweb: Simple file based output caching
Date: Sun, 7 Feb 2010 13:35:52 +0100
Message-ID: <201002071335.53801.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net> <4B6CBD05.6040604@eaglescrag.net> <201002070056.31665.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 13:36:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne6N1-0005Ft-12
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 13:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933671Ab0BGMgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 07:36:05 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46656 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933297Ab0BGMgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 07:36:01 -0500
Received: by bwz19 with SMTP id 19so1103894bwz.28
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 04:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vcw7J/1DzKUC0Cimn9zzwodX+kFJIpVxe1qXrJv1eiU=;
        b=NvtcJhKvfW2XW7Onak+Cm+0IvG46PfuTqMk+p/DDWzea0oWcZALOWBN2/s8dpu+6e7
         gKazhxRlOzgy1osGXEMi38VMCGuENg2GvOzsMlYBx6hRoqNmq1NzHs6e1BXspTYATcyG
         UAqvl1ETbgWNjd5akk9PR3ttJ/Y3XX4Wz25yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mIS65JFgP1JIFZ300TN89r9v1x+ZzBQxjDrbP8YYZiVg73EKKx49D8NERjb1UZkTQe
         p4MQ+90WL0ZA2LkRsKqEr6awIbR5Ioe9X03dH2tyZAEXpM5QfJF1nYvNhdCRyAHsoEBt
         A6ovZQayXa4vTnWXBxnOkvRloU1Upxx1wp3/Q=
Received: by 10.204.150.81 with SMTP id x17mr2595659bkv.200.1265546158972;
        Sun, 07 Feb 2010 04:35:58 -0800 (PST)
Received: from ?192.168.1.13? (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id 15sm1456603bwz.12.2010.02.07.04.35.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 04:35:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201002070056.31665.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139236>

On Sun, 7 Feb 2010, Jakub Narebski wrote:

> There is new version of this series in gitweb/cache-kernel-v2 in my
> git/jnareb-git.git fork (clone) of git.git repository at repo.or.cz.
> Now all commits have proper description (for first series one had to
> read comment section in emails for commit description), [...]

Below there are commit messages for gitweb/cache-kernel-v2 branch after
rebase and fixups:

commit 560e2ab10d0f8457fbeca7a26814ff3e32396f7b
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 11:27:22 2010 +0100

    gitweb: href(..., -path_info => 0|1)
    
    If named boolean option -path_info is passed to href() subroutine, use
    its value to decide whether to generate path_info URL form.  If this
    option is not passed, href() queries 'pathinfo' feature to check
    whether to generate path_info URL (if generating path_info link is
    possible at all).
    
    href(-replay=>1, -path_info=>0) is meant to be used to generate a key
    for caching gitweb output; alternate solution would be to use freeze()
    from Storable (core module) on %input_params hash (or its reference),
    e.g.:
      $key = freeze \%input_params;
    or other serialization technique.
    
    While at it document extra options/flags to href().
    
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

commit dd6e8dc27d5b799bd2a1aed03738195dfe3bc5e7
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 13:13:06 2010 +0100

    gitweb/cache.pm - Very simple file based caching
    
    This is first step towards implementing file based output (response)
    caching layer that is used on such large sites as kernel.org.
    
    This patch introduces GitwebCaching::SimpleFileCache package, which
    follows Cache::Cache / CHI interface, although do not implement it
    fully.  The intent of following established convention is to be able
    in the future to replace our simple file based cache e.g. by one using
    memcached.
    
    Like in original patch by John 'Warthog9' Hawley (J.H.) (the one this
    commit intends to be incremental step to), the data is stored in the
    case as-is, without adding metadata (like expiration date), and
    without serialization (which means only scalar data).
    
    To be implemented (from original patch by J.H.):
    * cache expiration (based on file stats, current time and global
      expiration time); currently elements in cache do not expire
    * actually using this cache in gitweb, except error pages
    * adaptive cache expiration, based on average system load
    * optional locking interface, where only one process can update cache
      (using flock)
    * server-side progress indicator when waiting for filling cache,
      which in turn requires separating situations (like snapshots and
      other non-HTML responses) where we should not show 'please wait'
      message
    
    Possible extensions (beyond what was in original patch):
    * (optionally) show information about cache utilization
    * AJAX (JavaScript-based) progress indicator
    * JavaScript code to update relative dates in cached output
    * make cache size-aware (try to not exceed specified maximum size)
    * utilize X-Sendfile header (or equivalent) to show cached data
      (optional, as it makes sense only if web server supports sendfile
      feature and have it enabled)
    * variable expiration feature from CHI, allowing items to expire a bit
      earlier than the stated expiration time to prevent cache miss
      stampedes (although locking, if available, should take care of
      this).
    
    The code of GitwebCaching::SimpleFileCache package in gitweb/cache.pm
    was heavily based on file-based cache in Cache::Cache package, i.e.
    on Cache::FileCache, Cache::FileBackend and Cache::BaseCache, and on
    file-based cache in CHI, i.e. on CHI::Driver::File and CHI::Driver
    (including implementing atomic write, something that original patch
    lacks).
    
    This patch does not yet enable output caching in gitweb (it doesn't
    have all required features yet); on the other hand it includes tests,
    currently testing only cache Perl API.
    
    Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/cache.pm                 |  269 +++++++++++++++++++++++++++++++++++++++
 t/t9503-gitweb-caching.sh       |   32 +++++
 t/t9503/test_cache_interface.pl |   84 ++++++++++++
 t/test-lib.sh                   |    3 +
 4 files changed, 388 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/cache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/test_cache_interface.pl

commit 3914e7da792fec50fcc64c0e644d54cf4451703a
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 13:13:17 2010 +0100

    gitweb/cache.pm - Stat-based cache expiration
    
    Add stat-based cache expiration to file-based GitwebCache::SimpleFileCache.
    Contrary to the way other caching interfaces such as Cache::Cache and CHI
    do it, the time cache element expires in is _global_ value associated with
    cache instance, and is not local property of cache entry.  (Currently cache
    entry does not store any metadata associated with entry... which means that
    there is no need for serialization / marshalling / freezing and thawing.)
    Default expire time is -1, which means never expire.
    
    To check if cache entry is expired, GitwebCache::SimpleFileCache compares
    difference between mtime (last modify time) of a cache file and current time
    with (global) time to expire.  It is done using CHI-compatible is_valid()
    method.
    
    Add some tests checking that expiring works correctly (on the level of API).
    
    To be implemented (from original patch by J.H.):
    * actually using this cache in gitweb, except error pages
    * adaptive cache expiration, based on average system load
    * optional locking interface, where only one process can update cache
      (using flock)
    * server-side progress indicator when waiting for filling cache,
      which in turn requires separating situations (like snapshots and
      other non-HTML responses) where we should not show 'please wait'
      message
    
    Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/cache.pm                 |   34 ++++++++++++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl |   10 ++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

commit a55625cb0f2d6c08a28e774fd2ddb4e5347a24b3
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 13:13:27 2010 +0100

    gitweb: Use Cache::Cache compatible (get, set) output caching
    
    This commit actually adds output caching to gitweb, as we have now
    minimal features required for it in GitwebCache::SimpleFileCache
    (a 'dumb' but fast file-based cache engine).  To enable cache you need
    at least set $caching_enabled to true in gitweb config, and copy cache.pm
    from gitweb/ alongside gitweb.cgi - this is described in more detail
    in the new "Gitweb caching" section in gitweb/README
    
    Currently cache support related subroutines in cache.pm (which are
    outside GitwebCache::SimpleFileCache package) are not well separated
    from gitweb script itself; cache.pm lacks encapsulation.  cache.pm
    assumes that there are href() subroutine and %actions variable, and
    that there exist $actions{$action} (where $action is parameter passed
    to cache_fetch), and it is a code reference (see also comments in
    t/t9503/test_cache_interface.pl).  This is remaining artifact from the
    original patch by J.H. (which also had cache_fetch() subroutine).
    
    Gitweb itself uses directly only cache_fetch, to get page from cache
    or to generate page and save it to cache, and cache_stop, to be used
    in die_error subroutine, as currently error pages are not cached.
    
    The cache_fetch subroutine captures output (from STDOUT only, as
    STDERR is usually logged) using either ->push_layer()/->pop_layer()
    from PerlIO::Util submodule (if it is available), or by setting and
    restoring *STDOUT.  Note that only the former could be tested reliably
    to be reliable in t9503 test!
    
    Enabling caching causes the following additional changes to gitweb
    output:
    * Disables content-type negotiation (choosing between 'text/html'
      mimetype and 'application/xhtml+xml') when caching, as there is no
      content-type negotiation done when retrieving page from cache.
      Use 'text/html' mimetype that can be used by all browsers.
    * Disable timing info (how much time it took to generate original
      page, and how many git commands it took), and in its place show when
      page was originally generated (in GMT / UTC timezone).
    
    Add basic tests of caching support to t9500-gitweb-standalone-no-errors
    test: set $caching_enabled to true and check for errors for first time
    run (generating cache) and second time run (retrieving from cache) for a
    single view - summary view for a project.
    
    If PerlIO::Util is available (see comments), test that cache_fetch
    behaves correctly, namely that it saves and restores action output in
    cache, and that it prints generated output or cached output.
    
    
    To be implemented (from original patch by J.H.):
    * adaptive cache expiration, based on average system load
    * optional locking interface, where only one process can update cache
      (using flock)
    * server-side progress indicator when waiting for filling cache,
      which in turn requires separating situations (like snapshots and
      other non-HTML responses) where we should not show 'please wait'
      message
    
    Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/README                          |   70 ++++++++++++++++++++++
 gitweb/cache.pm                        |   78 ++++++++++++++++++++++++
 gitweb/gitweb.perl                     |  102 ++++++++++++++++++++++++++++----
 t/gitweb-lib.sh                        |    2 +
 t/t9500-gitweb-standalone-no-errors.sh |   19 ++++++
 t/t9503/test_cache_interface.pl        |   93 +++++++++++++++++++++++++++++
 6 files changed, 352 insertions(+), 12 deletions(-)

commit 3e471ebd31e881ce1439f23075378c2ec6b95e4d
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 13:13:31 2010 +0100

    gitweb/cache.pm - Adaptive cache expiration time
    
    Add to GitwebCache::SimpleFileCache support for adaptive lifetime
    (cache expiration) control.  Cache lifetime can be increased or
    decreased by any factor, e.g. load average, through the definition
    of the 'check_load' callback.
    
    Note that using ->set_expires_in, or unsetting 'check_load' via
    ->set_check_load(undef) turns off adaptive caching.
    
    Make gitweb automatically adjust cache lifetime by load, using
    get_loadavg() function.  Define and describe default parameters for
    dynamic (adaptive) cache expiration time control.
    
    There are some very basic tests of dynamic expiration time in t9503,
    namely checking if dynamic expire time is within given upper and lower
    bounds.
    
    To be implemented (from original patch by J.H.):
    * optional locking interface, where only one process can update cache
      (using flock)
    * server-side progress indicator when waiting for filling cache,
      which in turn requires separating situations (like snapshots and
      other non-HTML responses) where we should not show 'please wait'
      message
    
    Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/cache.pm                 |   55 +++++++++++++++++++++++++++++++++++---
 gitweb/gitweb.perl              |   27 +++++++++++++++++-
 t/t9503/test_cache_interface.pl |   22 +++++++++++++++
 3 files changed, 97 insertions(+), 7 deletions(-)

commit 984390f99c33d82cd4ddbfa6e00c721d9e74cddb
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 13:13:52 2010 +0100

    gitweb: Use CHI compatible (compute method) caching
    
    If $cache provides CHI compatible ->compute($key, $code) method, use it
    instead of Cache::Cache compatible ->get($key) and ->set($key, $data).
    While at it, refactor regenerating cache into cache_calculate subroutine.
    
    GitwebCache::SimpleFileCache provides 'compute' method, which currently
    simply use 'get' and 'set' methods in proscribed manner.  Nevertheless
    'compute' method can be more flexible in choosing when to refresh cache,
    and which process is to refresh/(re)generate cache entry.  This method
    would use (advisory) locking to prevent 'cache miss stampede' (aka
    'stampeding herd') problem in the next commit.
    
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/cache.pm |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

commit 7d0109e4379f5187364edf7c25cdbc5247609f64
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 13:18:14 2010 +0100

    gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
    
    In the ->compute($key, $code) method from GitwebCache::SimpleFileCache,
    use locking (via flock) to ensure that only one process would generate
    data to update/fill-in cache; the rest would wait for the cache to
    be (re)generated and would read data from cache.
    
    Currently this feature can not be disabled (via %cache_options).
    
    
    A test in t9503 shows that in the case where there are two clients
    trying to simultaneously access non-existent or stale cache entry,
    (and generating data takes (artifically) a bit of time), if they are
    using ->compute method the data is (re)generated once, as opposed to
    if those clients are just using ->get/->set methods.
    
    To be implemented (from original patch by J.H.):
    * background building, and showing stale cache
    * server-side progress indicator when waiting for filling cache,
      which in turn requires separating situations (like snapshots and
      other non-HTML responses) where we should not show 'please wait'
      message
    
    Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/cache.pm                 |   29 ++++++++++++++++-
 t/t9503/test_cache_interface.pl |   65 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 2 deletions(-)

commit e7985f69eb9000860b155939d5fd7040e30f682f
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 13:19:21 2010 +0100

    gitweb/cache.pm - Serve stale data when waiting for filling cache
    
    When process fails to acquire exclusive (writers) lock, then instead
    of waiting for the other process to (re)generate and fill cache, serve
    stale (expired) data from cache.  This is of course possible only if
    there is some stale data in cache for given key.
    
    This feature of GitwebCache::SimpleFileCache is used only for an
    ->update($key, $code) method.  It is controlled by 'max_lifetime'
    cache parameter; you can set it to -1 to always serve stale data
    if it exists, and you can set it to 0 (or any value smaller than
    'expires_min') to turn this feature off.
    
    This feature, as it is implemented currently, makes ->update() method a
    bit assymetric with respect to process that acquired writers lock and
    those processes that didn't, which can be seen in the new test in t9503.
    The process that is to regenerate (refresh) data in cache must wait for
    the data to be generated in full before showing anything to client, while
    the other processes show stale (expired) data immediately.  In order to
    remove or reduce this assymetry gitweb would need to employ one of the two
    alternate solutions.  Either data should be (re)generated in background,
    so that process that acquired writers lock would generate data in
    background while serving stale data, or alternatively the process that
    generates data should pass output to original STDOUT while capturing it
    ("tee" otput).
    
    When developing this feature, ->is_valid() method acquired additional
    extra optional parameter, where one cap pass expire time instead of using
    cache-wode global expire time.
    
    To be implemented (from original patch by J.H.):
    * background building,
    * server-side progress indicator when waiting for filling cache,
      which in turn requires separating situations (like snapshots and
      other non-HTML responses) where we should not show 'please wait'
      message
    
    Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/cache.pm                 |   23 ++++++++++----
 gitweb/gitweb.perl              |    8 +++++
 t/t9503/test_cache_interface.pl |   63 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 8 deletions(-)

commit 19911970b8a811a6382e39a10b071bff1dd4bd70
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 13:20:46 2010 +0100

    gitweb/cache.pm - Regenerate (refresh) cache in background
    
    This commit removes assymetry in serving stale data (if it exists)
    when regenerating cache in GitwebCache::SimpleFileCache.  The process
    that acquired exclusive (writers) lock, and is therefore selected to
    be the one that (re)generates data to fill the cache, can now generate
    data in background, while serving stale data.
    
    This feature can be enabled or disabled on demand via 'background_cache'
    cache parameter.  It is turned on by default.
    
    To be implemented (from original patch by J.H.):
    * server-side progress indicator when waiting for filling cache,
      which in turn requires separating situations (like snapshots and
      other non-HTML responses) where we should not show 'please wait'
      message
    
    Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/cache.pm                 |   36 +++++++++++++++++++++++++++++-------
 gitweb/gitweb.perl              |    9 +++++++++
 t/t9503/test_cache_interface.pl |   14 ++++++++------
 3 files changed, 46 insertions(+), 13 deletions(-)

commit ce97bb5bc1660f6d5c9b9be68c556ac94097978c
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sun Feb 7 13:21:10 2010 +0100

    gitweb: Show appropriate "Generating..." page when regenerating cache
    
    When there exist stale/expired (but not too stale) version of
    (re)generated page in cache, gitweb returns stale version (and updates
    cache in background, assuming 'background_cache' is set to true value).
    When there is no stale version suitable to serve the client, currently
    we have to wait for the data to be generated in full before showing it.
    Add to GitwebCache::SimpleFileCache, via 'generating_info' callback,
    the ability to show user some activity indicator / progress bar, to
    show that we are working on generating data.
    
    Gitweb itself uses "Generating..." page as activity indicator, which
    redirects (via <meta http-equiv="Refresh" ...>) to refreshed version
    of the page after the cache is filled (via trick of not closing page
    and therefore not closing connection till data is available in cache,
    checked by getting shared/readers lock on lockfile for cache entry).
    The git_generating_data_html() subroutine, which is used by gitweb
    to implement this feature, is highly configurable: you can choose
    initial delay, frequency of writing some data so that connection
    won't get closed, and maximum time to wait for data in "Generating..."
    page (see %generating_options hash).
    
    Currently git_generating_data_html() contains hardcoded "whitelist" of
    actions for which such HTML "Generating..." page makes sense.
    
    
    This implements final feature from the original gitweb output caching
    patch by J.H.
    
    Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
    Signed-off-by: Jakub Narebski <jnareb@gmail.com>

 gitweb/cache.pm                 |   23 +++++-
 gitweb/gitweb.perl              |  154 ++++++++++++++++++++++++++++++++++++++-
 t/t9503/test_cache_interface.pl |   45 +++++++++++
 3 files changed, 216 insertions(+), 6 deletions(-)

-- 
Jakub Narebski
Poland
