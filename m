From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/6] Gitweb caching changes v2
Date: Sat, 12 Dec 2009 02:37:29 +0100
Message-ID: <200912120237.31254.jnareb@gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <200912111901.35781.jnareb@gmail.com> <4B228ED3.3030901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 12 02:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJGu9-00087y-9w
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 02:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762556AbZLLBgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 20:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761661AbZLLBgC
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 20:36:02 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:13496 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761390AbZLLBgA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 20:36:00 -0500
Received: by fg-out-1718.google.com with SMTP id 16so410085fgg.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 17:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZYae9Zs+MQWizn4tEsh9UJlV1w3gje2R4H3SZ5CwG8I=;
        b=tBknAvfomoTzhsPb9ZoEu+6w1NX80QsHYgZksleW3jxSKdJBLRwQIH4go3wp+s53UR
         JdE5uHTIcIdBg09YkoYDnD7r/FIPuTrtlXpSqM8UTFSEs41wYfxIudKca58zNRWqyavb
         u4TRbJis07ryCzZawG46IM0rblfXkKM05H09E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JETzxT7+JmwgoxGBv9/Z3mswRj9vek13wDLP/pSGCErpsK+wk6jrpA5XnfSuD9k3fH
         sW2/tsyHIlhBWQwlUAIbKJmYl6ZowNjHSnA5PrtrIthPdNRp7CrMBwozquN3WUv+LTvo
         7BcyupootBbKqo4iKzv68RSUvwGz0IXLAzkYc=
Received: by 10.103.50.32 with SMTP id c32mr828711muk.1.1260581766141;
        Fri, 11 Dec 2009 17:36:06 -0800 (PST)
Received: from ?192.168.1.13? (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id y2sm6223205mug.40.2009.12.11.17.36.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 17:36:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B228ED3.3030901@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135113>

On Fri, 11 Dec 2009, J.H. wrote:
> Jakub Narebski wrote:
>> On Fri, 11 Dec 2009, J.H. (John 'Warthog9' Hawley) wrote:
>>> Jakub Narebski wrote:
>>>> "John 'Warthog9' Hawley" <warthog9@kernel.org> writes:
>>>>>
>>>>>   GITWEB - File based caching layer
>>>>>
>>>> This patch didn't made it to git mailing list.  I suspect that you ran
>>>> afoul vger anti-SPAM filter.
>>>
>>> Yeah, it does seem that way (like I said eaten by a grue),

It _might_ be caused by the fact that you used attachement.  But it might
not; you can always use vger-taboo.perl script to check.

>>>> Does this "File based caching layer" have anything common with GSoC
>>>> 2008 project, available at git://repo.or.cz/git/gitweb-caching.git ?
>>>
>>> It *currently* has nothing to do with Lea's GSoC code but it is still my 
>>> intention, in long term, to integrate the two.

The question would be then whether it makes sense to have two caches at
different levels in the stack (see also discussion below about Lea 
approach).

>>> The patch, in all it's glory can be viewed at: 
>>> http://git.kernel.org/?p=git/warthog9/gitweb.git;a=commitdiff;h=42641b1e3bfae14d5cc2e0150355e89cb87951db
>>>
>>> It is anything but a small patch to gitweb, the patch is 117K and 
>>> comprises 3539 lines (including git header commit information).  There's 
>>> not any real good way to break it up as it's a bit of an all or nothing 
>>> patch.
>> 
>> First, why do you reinvent the wheel instead of using one of existing
>> caching interfaces like CHI or Cache::Cache (perhaps creating a custom
>> backend or middle layer which incorporates required features, like being
>> load-aware)?
> 
> Well for starters this isn't exactly a reinvention of the wheel, and 
> this isn't something "new" per-se.  This code has been actively running 
> on git.kernel.org for something like 3 - 4 years so there's something to 
> be said for the devil we know and understand.

Well, if it is not reinventing the wheel, then it is yak shaving (yet
another ...) ;-)

The fact that the code was used and tested at one single installation
doesn't mean that it doesn't have warts that could be avoided by using
ready solution (at least for parts of it).

> As well using the other  
> caching strategies involves adding dramatically more complex 
> interactions with caching layer.

I am hoping that if it was done right, by using CHI or Cache::Cache
caching interface, then choosing alternate caching engine, or adding
extra level of cache would be simple and decoupled from issues specific
to web app or gitweb in particular.

> The caching layer is actually quite  
> specific to how git + gitweb works and solves more than just "caching" 
> on the surface.  

The idea is for gitweb/cache.pm (or gitweb/Gitweb-Cache.pm, or 
gitweb/Gitweb/Cache.pm) is to encapsulate issues specific to gitweb,
like generating cache key, or printing "Generating...", etc.

Perhaps also the idea of filling cache in background (but see discussion
below about capturing STDOUT) could be put there.

> Specifically it solves the stampeding herd problem  
> which would have to be solved either way even if I didn't implement my 
> own caching, and since I had to do that caching was barely a step beyond 
> that to implement.

CHI tries to solve cache miss stampedes via expires_variance mechanism.
There is Cache::Adaptive (and its subclass Cache::Adaptive::ByLoad)
which does adaptive lifetime control (it accepts any Cache::Cache 
compatible cache, so I think it also accepts CHI compatible cache).
Those problems _were_ solved.

>>  This way changing from file-based cache to e.g. mmap based
>> one or to memcached would be very simple.
> 
> True but these are *VERY* different caching strategies than the one I've 
> got here, yes it's using files as a backend but it's doing so with 
> specific goals in mind.  As I've said I plan to integrate Lea's 
> memcached based caching into this in the future and that has different 
> advantages and disadvantages.

Errr... besides using Cache::Cache compatible cache (see!!!), for example
Cache::Memcached, Lea Wiemann's gitweb caching did caching at entirely
different level than original kernel.org's gitweb.

The stack for gitweb looks somewhat like this:

  git commands output       open my $fd, '-|, git_cmd(), ...
          |
          v
  parsed output data        parse_ls_tree_line, parse_commit, ...
          |
          v
  generated HTML etc.       print ...
          :
          V
       caching              optional
    reverse proxy           Varnish, Squid

If I understand correctly Lea Wiemann code cache git command output.
The fork of gitweb used at repo.or.cz does caching of parsed data at
least for most intensive projects list page.  This patch was about caching
generated output.  HTTP caching requires that gitweb can respond to
If-Modified-Since (and generate Last-Modified) and If-None-Match (and
generate ETag) in a time that is much faster than generating full response.

There are advantages and disadvantages for each method of caching; also
the balance might depend on the view used.  For example 'snapshot' view
is best cached via output caching with file-based cache, while for 
'blame_incremental' view straight caching of output doesn't make much
sense while caching command output should give good behaviour.

> At the end of the day the "normal" caching engines aren't as efficient 
> as mine and there is the case the very high performance sites are going 
> to have to investigate a number of different solutions to see what works 
> best for them.  Mine is also *dramatically* simpler to setup as well, 
> turn it on, point it at a directory and you're done.

Do you have any benchmarks?

>>  And you would avoid pitfals
>> in doing your own cache management.  perl-Cache-Cache should be available
>> package in extras repositories.
> 
> There's pitfalls if I do it myself, or I use one of the other "common" 
> perl modules.  I did it this way years ago, I've maintained it and it 
> works pretty well.  I won't admit that it's the smartest caching engine 
> on the planet, far from it, but it has evolved specifically for gitweb 
> and that itself saves me a lot of pitfalls from cache engine + gitweb 
> integration.

If I remember correctly the solution presented here has serious 
disadvantage of not having any cache expire policy, and not being 
size-aware.

>> If module is no available this would simply mean no caching, like in many
>> (or not so many) other cases with optional features in gitweb.
> 
> Yes, but as can be seen from how you enable various other caching 
> engines the setup of those is non-trivial, this is and either way 
> caching *HAS* to be explicitly turned on by the admin/user since they 
> are going to have to do *some* configuration, or at least be aware that 
> their webapp is going to chew up some sort of resource.

I wonder if there is any data that describes when one should enable 
caching, and when one can do without it, e.g. depending on the number
and total size of repositories presented via gitweb.

IMHO cache storage is orthogonal to expire policy, which in turn is
orthogonal on cache use in gitweb.  And those parts should be kept separate
(and tested independently), even if we decide on homegrown caching
solution.

>> Second, if you can't use CGI::Cache directly, you can always steal the
>> idea from it, then the change to gitweb itself would be minimal:
>> 
>>   "Internally, the CGI::Cache module ties the output file descriptor
>>   (usually STDOUT) to an internal variable to which all output is saved."
> 
> I thought about that 3 years ago, and decided it wasn't a good option 
> for gitweb.  Why?  There's too many assumptions throughout the code that 
> when you do a print it will go immediately out.  Things like error 
> messages and such.  Breaking out the prints into prints (which will do 
> what is expected) and passing around the output in the $output variables 
> makes it a lot simpler easier to differentiate about how / what your 
> looking at and a *LOT* easier to debug.

Note that in quite a few places we print directly to output, streaming
the response, for performance (to reduce latency).  If all data must be
first gathered in $output variable (increasing memory pressure in the
case of large files for 'blob_plain', large snapshots, large patches in
'patch' and 'patches' views) then we must wait for it to finish, and not
get data as soon as it is available.

Besides instead of just capturing STDOUT in tied variable (STDERR goes
to web server log courtesy of CGI.pm) we can tee it, i.e. capture it
to $output variable as it is streamed to web browser.  See Capture::Tiny
(although I am not sure how it would interact with CGI.pm logging) and
e.g. PerlIO::tee mechanism from PerlIO::Util.

Going the route of CGI::Cache would mean minimal changes to gitweb...
and no diference in performance if caching is turned off (see streaming).
 
>> P.S. I'll postpone critique of the patch itself for now.  The above issues
>> are much more important.
> 
> That's fine.  The issues your raising aren't new though, and stem back 
> to before I created gitweb-caching, got rehashed with Lea's patches and 
> not surprisingly are back on the table now.  Like I said above, there is 
> no one caching strategy that's perfect in all cases here and that's 
> again why I eventually plan to merge Lea's changes (which uses 
> memcached) in as well, I'm just trying to get code that I'm getting 
> considerable demand for, that's proven, upstream.

Well, there are two solutions.  One is first to decide on proper solution
for gitweb caching.  Another is to have _some_ caching and then improve it.


So below there are a few initial comments about gitweb/cache.pm code:

* gitweb/cache.pm should be, I think, a proper module (require'd or use'd)

* you do not follow coding style used elsewhere in gitweb, e.g. spaces
  around {} and (), for example it is

    }elsif( $cache_enable == 1 ){

  and should be

    } elsif ($cache_enable == 1) {

* flags that are boolean are compared to 0 and 1

* cache key should be generated from both PATH_INFO and QUERY_STRING
  in generic case (unless you turn off $path_info as default, and turn off
  support for path_info URLs); see %input_params hash or href(-replay=>1)

* gitweb till now does not include any variable data in error info

* duplicated code (e.g. fork / cacheUpdate + cacheDisplay / cacheUpdate...)

* inconsistent naming style: cache_fetch but cacheDisplay.

* old style open using globs instead of local filehandles:

    open(cacheFile, '<', "$fullhashpath");

  and should be

    open(my $cache_fh, '<', $fullhashpath);

* busy wait 'do { sleep 2; open ... } while (...)' instead of non-blocking
  wait like select / IO::Select.

That's all from skimming gitweb-ml-v2:gitweb/cache.pm
-- 
Jakub Narebski
Poland
