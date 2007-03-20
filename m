From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] More diff possibilities in gitweb
Date: Tue, 20 Mar 2007 02:41:03 +0100
Message-ID: <200703200241.04738.jnareb@gmail.com>
References: <20070317151731.GA32571@auto.tuwien.ac.at> <200703190020.55806.jnareb@gmail.com> <20070319220339.GA26080@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wuz/FXGCLZBSVLY"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Mar 20 02:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTTJ1-0006w3-Rl
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 02:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbXCTBiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 21:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbXCTBiP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 21:38:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:7512 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbXCTBiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 21:38:14 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1459739uga
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 18:38:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:message-id;
        b=TMJsafKGRaM+xmKOwsmA+507M/0tANsUp3OHWmtH2rW6/b3RrhJgAjEkB5YVdouHN7na/ATeAwNxFWBZjbykotOtFFbrKPiGJEjbw07Fzcs2GD3jxc+7IvXeZwh7YwKLRoZrXtWAIMfN3UBNqvtxUMkNmyl5rpj1O0JtH0JRx7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:message-id;
        b=hxZcVYIZojcLM9AkaDyoICC5YzYhDT+oKtR7G4+QhXHaUaJCEoE/KY/czumnmMaaKeeQ6MmMworrhCaoxRUKDeLkAH9c7TcpD0LD+6+gNopK9yNk4CL+BzZyucHzOAbrAAcoUH0dmFSSat63/B1GXKYGkNYEZYyhPyWYMw0R7pQ=
Received: by 10.67.21.11 with SMTP id y11mr412088ugi.1174354692678;
        Mon, 19 Mar 2007 18:38:12 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j2sm257231mue.2007.03.19.18.38.09;
        Mon, 19 Mar 2007 18:38:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070319220339.GA26080@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42690>

--Boundary-00=_wuz/FXGCLZBSVLY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Mar 19, 2007, Martin Koegler wrote:
> I tried to merge the two threads.
> 
> On Sun, Mar 18, 2007 at 10:55:59PM +0100, Jakub Narebski wrote:
>> On Sun, Mar 18, 2007, Martin Koegler wrote:
>>> On Sat, Mar 17, 2007 at 10:51:51PM +0100, Jakub Narebski wrote:
>>>
>>> Let's focus on the UI first:
>>> 
>>> Using a select box, as shown above, exposes only a small part of all
>>> possible combinations, eg. how to compare commits on different
>>> branches.
>> 
>> I assume you meant "e.g. it doesn't provide a way to compare commits
>> on different branches".
> 
> Yes
[...]
>> But after some thinking I guess that your idea has some merit
>> _provided_ that "(base | diff)" (by the way, what would happen
>> if someone would click "diff" without setting "base" first? is
>> "diff" inactive, or is some "base" default?) is added _only_ when
> 
> In my JavaScript solution, the user gets a message box in this case:
> "no base object selected".

This is a bad idea from UI point of view. Users don't like message boxes,
unless really, really necessary.

We can either do like MediaWiki engine does, i.e. have default base, be
it current version (tip of shortlog, history) or the previous (parent,
or rather first simplified parent) version. Or we can make "diff" part
of "(base | diff)" inactive and grayed out till base is selected, which
should be fairly easy in JavaScript.
 
>> web browser supports it. It means that it should appear only when
>> JavaScript is turned on (easy if links are added by JavaScript)
>> and when cookies are turned on (I'm not sure if you are checking
>> this).
> 
> No, there is no check at the moment. Buts this is basically checking
> the navigator.cookieEnabled property. A user could only reject some
> cookies, but catching this would probably be too complicated.

Please make it so.

>> I guess that we could (under control of gitweb configuration, %feature
>> hash or something like that) add links which would lead to server
>> setting a cookie, or adding unused CGI parameters ('hp', 'hpb' and
>> 'fp' are used only by 'diff' views).
[...]

>>> If depending on cookies is a problem for some out there, the base
>>> object can be passed in the URLs as fallback. It would require, that
>>> the select base object is included in every link, which gitweb
>>> generates.
>> 
>> Not much of a problem. Generation of links is consolidated in href()
>> subroutine, and it would be fairly easy to add passing through base
>> parameters, if they are needed or not. It means that if 'shortlog' view
>> was passed 'hp' parameter then "diff" links (or "diff <sha1>" links,
>> or "diff sel"/"diff selected" links) would lead to diff with given base.
> 
>> First, generating gitweb links in gitweb _all_ goes through href()
>> subroutine, so it would be fairly easy to implement it server side,
>> i.e. directly in gitweb.perl. 
> 
> This has on complication: href only generats the url. The link is
> generated in the caller. We would need a new wrapper for this.
> 
> [...]

I was thinking about the following solution: by default "base" part
of server-side plain HTML "(base | diff)" would lead to current URL
but with 'hp' and if necessary also 'hpb', 'fp' CGI parameters added,
(e.g. if current URL is
  p=project.git;a=shortlog;h=next
then "base" link somewhere deeper in the "shortlog" would be:
  p=project.git;a=shortlog;h=next;hp=<sha1 of a commit>
i.e. with appropriate 'hb' param added). This of course would mean
that "base" link would mean additional request for the server. And
newly served page would have modified "diff" part of "(base | diff)"
to have just set base as base.

If non-diff view has diff-related ('hp', 'hpb', 'fp') parameters set,
they are passed to "diff" part of "(base | diff)" links; if they
are not set, "diff" part is inactive (unless there is some default).

Of course when we finally view requested diff, the selected base is
lost... unless we save it in a cookie, server-side.

>>> Currently, only few combinations are implemented. Future version could
>>> integrate tags (as an tag links to one commit). Additionally,
>>> comparing tags/commits with a tree could be enabled, as a tag/commit
>>> link to one tree.
>> 
>> Diffs makes sense only between two commit-ish (commit-ish being commit
>> or a tag; head also denotes a commit) for which we need 'h' and 'hp'
>> params,  between two tree-ish (tree-ish being tree, commit or a tag)
>> for which we need 'h'/'hb' and 'hp'/'hpb' and usually 'f', sometimes
> 
> For tree diffs, I currently only support h/hp. Using hb/hbp and f/fp
> would require, that both trees share the same file name.

Not true. You can use extended sha1 syntax to specify trees by
revision (commit/base hash) and directory name (path): see 
"SPECIFYING REVISIONS" section in git-rev-parse(1):

 * A suffix : followed by a path; this names the blob or tree at the given
   path in the tree-ish object named by the part before the colon.

So if 'h=<tree_hash>' is given, we use it's value; if only 
'hb=<commitish_hash>' and 'f=<filename>' are given, use
<commitish_hash>:<filename> to specify tree. Not hard.

>> 'fp', and finnally between two blobs, for which we need 'h'/'hb' and
>> 'hp'/'hpb' and usually 'f', sometimes 'fp'.
> 
> For blob diffs, I prefer to use only h/hp (and f/fp for showing nice
> file names). I fall back to hb/hpb and f for the blobs in the history
> views (where h is not available), which has the drawback, that both
> blobs must have the same name.

I think it works. If I remember correctly in commitdiff and commit views,
ahen file modification is detected as rename the blobdiff link is
generated with both 'h' (for blob hash) and 'hb' (for commit hash),
and 'hp' and 'hbp', and with 'f' and 'fp'; and it just works.

>> By the way, I'm not that sure if gitweb handle correctly request for
>> diff of two _different_ tree-ish, or two arbitrary different files.
> 
> If you use not hb/hbp, this works.

See above.

>>> 1) introduce git_treediff
>> 
>> NOTE: git_treediff is in some parts very similar (I think) to
>> git_commitdiff with the exception of not being there commit message,
>> nor links to parents, and I'd like very much to avoid code repetition
>> (duplication) betweem git_treediff and git_commitdiff if possible.
>> On the other hand git_treediff is similar to git_blob in handling
>> its parameters ('h', 'hp' but also 'hb', 'hpb' and 'f', 'fp').
> 
> I created git_treediff out of git_commitdiff.

Perhaps some code could be shared, i.e. separated into common subroutine,
or git_commitdiff could be generalized to take also trees?

>>> For me, this would be no problem, but for high load servers (eg. gitweb at
>>> kernel.org), it would incread the system load.
>> 
>> I think use JavaScript if possible, and server-side implementation
>> if not would be good compromise.
> 
> I'll try to implement a solution for this.

Thanks in advance.

>> I'm just wondering why did you not used git for development. You have
>> to have git installed to test gitweb, and it would be best to have
>> git.git repository fetched to base your work on newest 'master' version
>> (or rather 'origin/master' or 'origin' version). So it would be natural
>> to use git to work on gitweb, and to send git patches.
> 
> gitweb.cgi is generated out of gitweb.perl. Then I need to manually
> change some parameters in it and put it on a webserver. For
> developing, it's easier for me to edit the cgi-script on the
> server. In a diff of gitweb.cgi, I have to remove the unrelated
> changes, for eg. setting paths parameters.
> 
> I would be interessted, how git can help me in this workflow?

There are two solutions. First is to use script to generate gitweb.cgi
out of (just modified) gitweb.perl, setting the parameters while at
it, and install it. See attached gitweb-update.sh which I use for this.
Another would be to use config file to set appropriate parameters;
see attached gitweb_config.perl which I use for similar purposes.

>>> @@ -1835,6 +1837,7 @@
>>>  		close $fd;
>>>  	}
>>>  
>>> +	print '<script type="text/javascript" src="gitweb.js"></script>';
>>>  	print "</body>\n" .
>>>  	      "</html>";
>>>  }
>> 
>> I'd rather have end of line after closing '</script>', and have scripts
>> in the head section, not in body.
> 
> For my prototype, it was easier put the script at the end. Putting it
> in the header would require, that I call the JavaScript load function
> in the body onload event. In the end version, I'll change that.

I can understand this, but I think patches _for the inclusion_ should
have scripts included in the header.

[...]
> Do git-diff-tree offers an option to compare in two trees two
> different file names? If not, using hb would require, that both trees
> have the same name. In this case, as all tree links seems to have h, I
> see no use for hb/hpb.

See above. You can use hb:f and hpb:fp (or hpb:f if fp is not set,
meaning fp=f).

-- 
Jakub Narebski
Poland

--Boundary-00=_wuz/FXGCLZBSVLY
Content-Type: text/plain;
  charset="iso-8859-1";
  name="gitweb-update.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="gitweb-update.sh"

#!/bin/bash

#BASEDIR="/home/jnareb/"

#BINDIR="/usr/bin"
BINDIR="/home/local/git"

function make_gitweb()
{
	pushd "/home/jnareb/git/"

	make GITWEB_PROJECTROOT="/home/local/scm" \
	     GITWEB_CSS="/gitweb/gitweb.css" \
	     GITWEB_LOGO="/gitweb/git-logo.png" \
	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
	     bindir=$BINDIR \
	     gitweb/gitweb.cgi

	popd
}

function copy_gitweb()
{
	cp -fv /home/jnareb/git/gitweb/gitweb.{cgi,css} /home/local/gitweb/
}

make_gitweb
copy_gitweb

# end of gitweb-update.sh

--Boundary-00=_wuz/FXGCLZBSVLY
Content-Type: text/plain;
  charset="iso-8859-1";
  name="gitweb_config.perl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="gitweb_config.perl"

#!/usr/bin/perl

# gitweb configuration

our $version = "current";
#our $GIT = "/usr/bin/git";
our $GIT = "/home/local/git/git";
our $projectroot = "/home/local/scm";
our $home_link_str = "projects";
our $site_name = "[localhost]";
our $site_header = "";
our $site_footer = "";
our $home_text = "indextext.html";
our @stylesheets = ("file:///home/jnareb/git/gitweb/gitweb.css");
our $logo = "file:///home/jnareb/git/gitweb/git-logo.png";
our $favicon = "file:///home/jnareb/git/gitweb/git-favicon.png";
our $projects_list = "";
our $export_ok = "";
our $strict_export = "";
our @git_base_url_list = ("/home/jnareb/git");

--Boundary-00=_wuz/FXGCLZBSVLY--
