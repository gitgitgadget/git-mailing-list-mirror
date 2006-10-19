From: "Tim Webster" <tdwebste@gmail.com>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 22:57:24 +0800
Message-ID: <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	 <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <4536EC93.9050305@utoronto.ca>
	 <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>
	 <46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com>
	 <45373E27.3050209@op5.se> <vpqwt6wsmb5.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Christian MICHON" <christian.michon@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 16:57:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaZKs-0004pU-H7
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 16:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946105AbWJSO51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 10:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946106AbWJSO51
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 10:57:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:60562 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946105AbWJSO50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 10:57:26 -0400
Received: by ug-out-1314.google.com with SMTP id o38so476463ugd
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 07:57:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WWtZ3v0OzbaKagzPolmthaTvpND49ogrGK6wgrcAFey6lf28c2yDup/mM3hMbgkCgUkQeR6z3CTxdvNBHeQuJTHupkxfaAeMI1UeLk9l0d8foLxrcDU/YGSIGcmScETJjx+iZW73h9o8E6rQ7PgTC8zo2hC3XPDE1cTq67zwmGY=
Received: by 10.82.127.15 with SMTP id z15mr55848buc;
        Thu, 19 Oct 2006 07:57:24 -0700 (PDT)
Received: by 10.67.100.9 with HTTP; Thu, 19 Oct 2006 07:57:24 -0700 (PDT)
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
In-Reply-To: <vpqwt6wsmb5.fsf@ecrins.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29354>

On 10/19/06, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Andreas Ericsson <ae@op5.se> writes:
>
> > Perhaps not, but the tone is friendly (mostly), the patience of the
> > bazaar people seems infinite and lots of people seem to be having fun
> > while at the same time learning a thing or two about a different SCM.
> > Best case scenario, both git and bazaar come out of the discussion as
> > better tools. If there would never be any cross-pollination, git
> > wouldn't have half the features it has today.
>
>


Thanks everyone for taking time to explain details.

However, I don't use SCM for code development. I use it for collaborative
documentation, white boarding and tracking configurations.
In fact in my company no one uses SCM for code development.
Everyone here uses it for collaborative documentation and white boarding.
Only I use SCM for tracking configurations.

I think of SCMs in terms of an SCM core and SCM tools.

First I want to say every SCM I know of sucks when it comes to tracking
configurations, simply because they don't record or restore file metadata,
like perms, ownership, and acl. I don't see recording or restoring
file metadata as part of the SCM core. I do however feel an SCM core needs to
have provisions for extended file inventory information. The problem
with extended file inventory information, it is fs specific. For this reason I
feel it is essential that the SCM core allow multiple sets of extended file
inventory information. The SCM tools are responsible, based on the local
config, for recording metadata and creating extended file inventory,
translating file metadata of one file system. When tracking configurations
octopus merges are surprisingly common. If a configuration changed is
not signed off by a responsible person, it can not be accepted. Doing
otherwise is simply an invitation to attackers and makes trouble shooting
far too difficult. Also configuration file in one directory will most often not
be members of the same repo. For example each file etc in directory would
members of different repos according to its associated application/pkg.

Somethings I like the SCM tools to handle. Personally I would like the
SCM tools to be platform independent. This would ensure that correct
things happening on ext3 mounted on windows.
I don't think execute bit belongs in the basic file inventory information.
Instead I would like to use this replace by a filter in the extended
file inventory
indicating what file metadata if any should be recorded or restored.
When the local SCM tools config has use metadata enable, the filter is used.
A filter lets the user select file metadata to record/restore such as;
record ownership, record permissions, record acl.

For SCM configuration tracking to function reliably, pulls, pushes and merges
need to be atomic. Personally I like my servers to pull change updates. And
I like to push changes I make on local servers to branches. On configuration
master merge the  branches into groups. When the server pulls changes
for a particular application/pkg, the following is a list of steps that need to
occur.
The SCM tools, perform a pre update step, such as optionally stopping a service
pull updates and build changes files in a scratch space, than apply
file metadata,
unchanged files would be links from the scratch space to the original files,
verify all files are correct by checking their sha1 or md5,
atomically move configuration files and scripts to install them,
perform a post update step,  such as starting or reloading a service.
The pre update step and the post update are very much like pkg pre and post
install scripts. The pre update and post update scripts are in fact part of the
application/pkg configurations files.


Collaborative document editing and white boarding are other requirements.
odf and svg are xml file formats. I would like to see an efficient
xml diff as part of the SCM core. Using mime types SCM tools can unzip
files, bundles, and use mime type information to the SCM core xml
diff, plain diff
as required. I think it is essential that the SCM core include
previsions for multiple
repo partners. For example this can be used to create fail over star
scm architecture.
In collaborative document editing it is often the case where you want to
compress / summarize some of the change history.

We currently use our scm based collaborative document editing as an ad
hock white
board, coordinating our commits and updates via IM. :)
It would be nice if the SCM tools included rss feeds for communicating zip
patch bundles.
