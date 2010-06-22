From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/11 GSoC] gitweb: Split gitweb into modules
Date: Tue, 22 Jun 2010 22:29:17 +0200
Message-ID: <201006222229.17623.jnareb@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com> <201006221311.05339.jnareb@gmail.com> <AANLkTim2qOENdcyjbYF8NNmEfMJ-ijhwQY-Pf46JWuiO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 22:29:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORA6A-0005OP-At
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 22:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab0FVU30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 16:29:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:45173 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab0FVU3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 16:29:25 -0400
Received: by fg-out-1718.google.com with SMTP id l26so150353fgb.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lCoZdGyFO0YeuVqDKOgHSCVIqMpCPFvtmPyF8jHA8Pw=;
        b=SQmAYepOM43xKXwUwDm39lAMPy0Q2ytwwU2G3r9soa7svxXhtzdTm0Sy5RD4gDEZoB
         TU0yKW+5VOOuSAeY5d9aDCQxzV0jy3gJtzcrVD0im5oV/ABnCxp3484DJ3TBwek2/zd8
         rLyrucDQML5JE9eqMxqFoH7+qGs3K6EnvvOkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EJ8qojUlaDc19r0XWuMFdlJoNfNHKbEeZbSQnQssuue8JjseWrU1UggqLRFJ3mRk2T
         ncqnie2r34K3pQnZUPRIPk6Iq2Wc6eWvNfufPnwmpCSXEy9X9vNUZfWFPqtA44PS7cnJ
         0alHTRreTDXa5RWms6lVFvzkxAQFqJhEWrzpk=
Received: by 10.87.72.2 with SMTP id z2mr11242128fgk.29.1277238563084;
        Tue, 22 Jun 2010 13:29:23 -0700 (PDT)
Received: from [192.168.1.15] (abvn56.neoplus.adsl.tpnet.pl [83.8.211.56])
        by mx.google.com with ESMTPS id e3sm11859991fga.19.2010.06.22.13.29.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 13:29:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTim2qOENdcyjbYF8NNmEfMJ-ijhwQY-Pf46JWuiO@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149492>

On Tue, 22 June 2010, Pavan Kumar Sunkara wrote:
> 
> So, If you can tell me what I need to change in this series, I would
> like to complete it and send a second version so that you can ack it
> and junio can merge it soon.

I think this series is of quite good quality, perhaps with the sole
exclusion of the problem with some modules not being clear of what they
should contain, but I don't think the issue is show-stopper.  Note that
any O.K. after description of module means that I think that it is good
as it is now.

More important than my ACK would be ACK from your mentors.

Also, you don't need to wait for the code to be merged.  That's what
(interactive) rebase and patch management interfaces like StGit, Guilt
and TopGit are for ;-)


> 2010/6/22 Jakub Narebski <jnareb@gmail.com>:
>> On Tue, 22 June 2010 at 03:30:36 +0530, Pavan Kumar Sunkara wrote:

>>> The modules created and being used by Gitweb are
>>>       Gitweb::Git
>>>       Gitweb::Config
>>>       Gitweb::Request
>>>       Gitweb::Escape
>>>       Gitweb::RepoConfig
>>>       Gitweb::View
>>>       Gitweb::Util
>>>       Gitweb::Format
>>>       Gitweb::Parse
>>
>> What I would like to see here is a dependency graph, i.e. which modules
>> include (use) which modules, and perhaps also how much this split
>> reduces size of main gitweb.perl file.
> 
> The dependency is written in individual commits.

I have noticed, and thank you for that.

Nevertheless some upfront description of module dependencies, as a
(partial) description of overall architecture, would be nice to have
here.  Something like:

   Gitweb::Git
   Gitweb::Config
     Gitweb::Git ($git_dir)
   Gitweb::Request
   Gitweb::Escape
     Gitweb::Config ($fallback_encoding)
   Gitweb::RepoConfig
     Gitweb::Git, Gitweb::Config, Gitweb::Escape, Gitweb::Request
   Gitweb::View
     Gitweb::Git, Gitweb::Config, Gitweb::Escape, Gitweb::Request
     Gitweb::RepoConfig
   Gitweb::Util
     ?
   Gitweb::Format
     Gitweb::Config, Gitweb::Escape, Gitweb::Request,
     Gitweb::View (?)
   Gitweb::Parse
     Gitweb::Git, Gitweb::Escape, Gitweb::Util,
     Gitweb::View (die_error)


>>> Shortlog:
>>> =========

>>> 3. gitweb: Create Gitweb::Git module
>>>
>>> Create a Gitweb::Git module in  'gitweb/lib/Gitweb/Git.pm'
>>> to deal with running git commands (and also processing output
>>> of git commands with external programs) from gitweb.
>>
>> The "processing output of git commands with external programs"
>> looks a bit strange to me.  If it is about quote_command()
>> subroutine, it is more about shell escaping of commands, or
>> about running other programs... but it might be O.K., if what
>> you want to say that quote_command() is used in pipe-ing output
>> of git commands (e.g. git-archive) to other programs (e.g. gzip).
>>
>> So take the above comment with a bit of salt...
> 
> Actually that message has been written by you itself in one of the
> earlier threads.

Well, as you can see coming up with a good commit message is not easy.
Nevertheless current message is, I guess, good enough.

>>> 4. gitweb: Create Gitweb::Config module
>>>
>>> Create Gitweb::Config module in 'gitweb/lib/Gitweb/Config.pm'
>>> to store all the configuration variables and subroutines
>>> regarding the gitweb.perl script.
>>>
>>> This module depends only on $git_dir from Gitweb::Git and
>>> includes most of the configuration related variables and
>>> subroutines (Including those required for configuration
>>> of gitweb features).
>>
>> "Most" meaning what?  Which subroutines weren't moved, and why (they
>> should not be in Gitweb::Config, they cannot be moved for technical
>> reasons)?
> 
> Yes, due to either unment dependency or circular dependency problem.
> But no need to worry as they are very small.

Could you _*LIST*_ those subroutines that you feel should belong in
Gitweb::Config but could not be put in it, and write _why_ they could not
be put (on what subroutines / variables do they depend that it makes
impossible to move them)?

>>>
>>> Subroutines moved:
[...]
>>>       configure_gitweb_features
>>
>> I'm not sure if configure_gitweb_features() should be there, as it
>> is run-once subroutine, about flow of the main program... but perhaps
>> it is O.K. to have it here.
> 
> That's what I thought.

All right.

By the way, in the future we might think about making this module use
object oriented interface, and/or tie-ing %features hash to it.  But that
is not something to worry about now.

>>> 5. gitweb: Create Gitweb::Request module
>>>
>>> Create a Gitweb::Request module in 'gitweb/lib/Gitweb/Request.pm'
>>> to store and handle all the cgi params and related variables
>>> regarding the gitweb.perl script.
>>>
>>> This module is intended as standalone module, which does not require
>>> (include) other gitweb' modules to avoid circular dependencies.
>>>
>>> validate_project and validate_action can't be included in this
>>> module due to unmet dependencies.
>>
>> What unment dependencies?  Can it be worked around by changing their
>> signatures to use additional parameters, e.g.:
>>
>>  sub validate_action {
>>        my $input = shift || return undef;
>>        my $actions = shift || return undef;
>>
>>        return undef unless exists $actions->{$input};
>>        return $input;
>>  }
> 
> Yes. I think we can but don't you think that we need to import
> %actions everytime we use validate_action.
> So, I figured it would be better If i leave it untouched for now.

Well, changing subroutines could be thought as being ot of scope of
current series, which is about splitting gitweb and moving subroutines to
appripriate modules... unless it would be not possible because of
circular dependencies problem (but I guess it is not the case,
ultimately).

> 
>> But I guess it would be very hard to do the same with validate_project.
>> Also such change might be out of scope for _this_ series.

Perhaps it would be better then to move _all_ validate_* subroutines to
separate Gitweb::Request::Validate module... unless they are used by some
subroutine from Gitweb::Request.

>>>
>>> Subroutines moved:
>>>       evaluate_uri
>>>       evaluate_query_params
>>>       validate_pathname
>>>       validate_refname
>>
>> I'm not completly sure if validate_* subroutines should be not separate,
>> as they do require more knowledge about setup, and about git repositories
>> served, than the rest of Gitweb::Request subroutines...
> 
> But they are being used in Gitweb::Request subroutines, so I included
> them in there.

Which Gitweb::Request subroutine uses validate_* subroutines?  Neither
evaluate_uri, nor evaluate_query_params, nor evaluate_path_info uses
them.  And evaluate_and_validate_params can be in Gitweb::Request::Validate.

If there is circular dependency in reasoning given above, please explain
it.

>>> 6. gitweb: Create Gitweb::Escape module
>>>
>>> Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
>>> to store all the quoting/unquoting and escaping subroutines
>>> regarding the gitweb.perl script.
>>>
>>> This module imports $fallback_encoding variable from
>>> Gitweb::Config module to use it in sub 'to_utf8'
>>>
>>> Subroutines moved:
[...]
>>>       unquote
>>
>> Shouldn't unquote be in Gitweb::Parse, as contrary to the rest of
>> subroutines is is not about gitweb output escaping/quoting, but
>> about processing (parsing) output of git commands?  Perhaps it
>> could even be provate to Gitweb::Parse (i.e. not exported by
>> default)...
> 
> It would result in circular dependency. So, Escape module is best for
> it's place.

Errr... how?  If unquote is used only by subroutines in Gitweb::Parse
(and I think it is), it could be local to Gitweb::Parse, not even
exported (by default).  Please explain.

>>> 7. gitweb: Create Gitweb::RepoConfig module
>>>
>>> Create a Gitweb::RepoConfig module in 'gitweb/lib/Gitweb/RepoConfig.pm'
>>> to store and handle all the configuration and subroutines
>>> related to a single repository regarding the gitweb.perl script.
>>>
>>> This module depend on several other modules like Git.pm,
>>> Config.pm, Request.pm and Escape.pm.
>>>
>>> It also include subroutines regarding project_list and
>>> it's handling.
>>
>> Why?  Is it to not have too many tiny modules, or is simply there no
>> single good place where to put this subroutine?
> 
> There is no single good place. Anyhow, as they are regarding project
> configuration, I thought it would be better place for it.

O.K.

>>> 8. gitweb: Create Gitweb::View module
>>>
>>> Create Gitweb::View module in 'gitweb/lib/Gitweb/View.pm'
>>> to store the subroutines related to the HTML output
>>> for gitweb.
>>
>> I find that this module looks a bit like a collection of fairly unrelated
>> subroutines at very different levels of abstractions.
>>
>> I guess that you don't want to split gitweb into too many modules,
>> and splitting gitweb is more of one of steps to final goal of adding
>> write functionality to gitweb, rather than the goal in and of itself.
>> Nevertheless it would be good to be able to immediately know from the
>> description of module what kind of subroutines should be there.

Any comment on this, if you don't mind?  Even "I don't want to think more
about better split" would be all right for me.

>>> This module depends on Git.pm, Config.pm, Request.pm,
>>> Escape.pm and RepoConfig.pm. Some subroutines which
>>> output HTML but are not included in this module due
>>> to unmet dependencies.
>>
>> Which subroutines and what unmet dependencies?
> 
> action specific HTML divs. They include format_* and parse_* subs.

Thanks for this info.  It should be, IMHO, in the comit message.

But... Shouldn't all format_* subs be in Gitweb::Format anyway?
Shouldn't all parse_* subs be in Gitweb::Parse anyway?  Which of format_*
and parse_* do you feel that belong here?

>>> 9. gitweb: Create Gitweb::Util module
>>>
>>> Create Gitweb::Util module in 'gitweb/lib/Gitweb/Util.pm'
>>> to store the git utility subroutines related to gitweb.
>>>
>>> This module include subroutines in various categories
>>> such as git utility subs invoking git commands, git
>>> utility subs accessing git repository, mimetype related
>>> subs and HTML output utility subs.
>>>
>>> Subroutines moved:
>>>       git_get_head_hash
[...]
>>>       is_patch_split
>>
>> O.K.
>>
>>>       run_highlighter
>>
>> _Perhaps_ with exception of this subroutine.
> 
> Well. It was in the utility category in gitweb.perl script. So, I
> added it in here without giving much thought.

Well, it is good explanation.  All right, then.

>>> 10. gitweb: Create Gitweb::Format module
>>>
>>> Create Gitweb::Format module in 'gitweb/lib/Gitweb/Format.pm'
>>> to store the subroutines related to formatting of HTML
>>> fragments required for gitweb.
>>>
>>> This module depends on Config.pm, View.pm, Escape.pm,
>>> Util.pm and Request.pm. It mainly contain functions returning
>>> short HTML fragments or transforming HTML fragments. Also
>>> include subroutines regarding avatar formatting.
>>
>> Why it depends on Gitweb::View, and not the reverse?  I understand why
>> it depends on Gitweb::Config and Gitweb::Escape, and I guess it needs
>> $cgi from Gitweb::Request (or is it something more?).
> 
> $hash, $hash_parent also.

Why it depends on Gitweb::View?  Is it because of ubiquitous and
troublesome :-) die_error?

>>> 11. gitweb: Create Gitweb::Parse module
>>>
>>> Create Gitweb::Parse module in 'gitweb/lib/Gitweb/Parse.pm'
>>> to store the subroutines which related to parsing functions
>>> required for gitweb.
>>>
>>> This module depends on Git.pm, Escape.pm, View.pm and Util.pm.
>>
>> Why it depends on Gitweb::View?  It is a strange dependency.
>> I understand depending on Gitweb::Git to some extent, I'm not sure
>> if we shouldn't simply move unescape to it instead of requiring
>> Gitweb::Escape (unless there is more: to_utf8 perhaps?), and
>> I understand that Gitweb::Util has some required subroutines.
> 
> for die_error.

Ah, I se that any run of git command is protected with 
'or die_error(...)'.  Hmmm, not very good.

Well, in the future we could think about decoupling Gitweb::Parse from
other modules, but for now it should be enough to mention in commit
message that Gitweb::Parse depends on Gitweb::View because of die_error.
Good for now.  O.K.

Perhaps die_error should be in Gitweb::Carp?  But it neds git_header_html
etc. anyway.  Ugh.

-- 
Jakub Narebski
Poland
