From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] Documentation: Grammar correction, wording fixes and
	cleanup
Date: Wed, 24 Aug 2011 07:27:25 -0400
Message-ID: <1314185245.13674.7.camel@drew-northup.unet.maine.edu>
References: <7vliujre93.fsf@alter.siamese.dyndns.org>
	 <1314145955-23444-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Wed Aug 24 13:28:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwBct-0006UE-AR
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 13:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab1HXL2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 07:28:02 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:48122 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab1HXL2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 07:28:00 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p7OBRRLY019708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 24 Aug 2011 07:27:27 -0400
In-Reply-To: <1314145955-23444-1-git-send-email-bwalton@artsci.utoronto.ca>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p7OBRRLY019708
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1314790047.69911@9G6/bsZBlMtTFAF8g9XUtA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179995>


On Tue, 2011-08-23 at 20:32 -0400, Ben Walton wrote:
> Correct a few grammar issues in gitrepository-layout.txt and also
> rewords a few sections for clarity.
> 
> Remove references to using http-fetch without -a to create a broken
> repository.
> 
> Mark a few areas of the repository structure as legacy.
> 
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---

Thanks Ben.
Looks good to me. I haven't tried applying it yet (it might not apply to
my bowl of breakfast cereal so well, but then again I should not be
surprised).

>  Documentation/gitrepository-layout.txt |   58 +++++++++++++++-----------------
>  1 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index eb3d040..5c891f1 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -23,32 +23,25 @@ objects::
>  	Object store associated with this repository.  Usually
>  	an object store is self sufficient (i.e. all the objects
>  	that are referred to by an object found in it are also
> -	found in it), but there are couple of ways to violate
> -	it.
> +	found in it), but there are a few ways to violate it.
>  +
> -. You could populate the repository by running a commit walker
> -without `-a` option.  Depending on which options are given, you
> -could have only commit objects without associated blobs and
> -trees this way, for example.  A repository with this kind of
> -incomplete object store is not suitable to be published to the
> -outside world but sometimes useful for private repository.
> -. You also could have an incomplete but locally usable repository
> -by cloning shallowly.  See linkgit:git-clone[1].
> -. You can be using `objects/info/alternates` mechanism, or
> -`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanism to 'borrow'
> +. You could have an incomplete but locally usable repository
> +by creating a shallow clone.  See linkgit:git-clone[1].
> +. You could be using the `objects/info/alternates` or
> +`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanisms to 'borrow'
>  objects from other object stores.  A repository with this kind
>  of incomplete object store is not suitable to be published for
>  use with dumb transports but otherwise is OK as long as
> -`objects/info/alternates` points at the right object stores
> -it borrows from.
> +`objects/info/alternates` points at the object stores it
> +borrows from.
>  
>  objects/[0-9a-f][0-9a-f]::
> -	Traditionally, each object is stored in its own file.
> -	They are split into 256 subdirectories using the first
> -	two letters from its object name to keep the number of
> -	directory entries `objects` directory itself needs to
> -	hold.  Objects found here are often called 'unpacked'
> -	(or 'loose') objects.
> +	A newly created object is stored in its own file.
> +	The objects are splayed over 256 subdirectories using
> +	the first two characters of the sha1 object name to
> +	keep the number of directory entries in `objects`
> +	itself to a manageable number. Objects found
> +	here are often called 'unpacked' (or 'loose') objects.
>  
>  objects/pack::
>  	Packs (files that store many object in compressed form,
> @@ -85,7 +78,7 @@ objects/info/http-alternates::
>  
>  refs::
>  	References are stored in subdirectories of this
> -	directory.  The 'git prune' command knows to keep
> +	directory.  The 'git prune' command knows to preserve
>  	objects reachable from refs found in this directory and
>  	its subdirectories.
>  
> @@ -119,16 +112,17 @@ HEAD::
>  +
>  HEAD can also record a specific commit directly, instead of
>  being a symref to point at the current branch.  Such a state
> -is often called 'detached HEAD', and almost all commands work
> -identically as normal.  See linkgit:git-checkout[1] for
> -details.
> +is often called 'detached HEAD.'  See linkgit:git-checkout[1]
> +for details.
>  
>  branches::
>  	A slightly deprecated way to store shorthands to be used
> -	to specify URL to 'git fetch', 'git pull' and 'git push'
> -	commands is to store a file in `branches/<name>` and
> -	give 'name' to these commands in place of 'repository'
> -	argument.
> +	to specify a URL to 'git fetch', 'git pull' and 'git push'.
> +	A file can be stored as `branches/<name>` and then
> +	'name' can be given to these commands in place of
> +	'repository' argument.  See the REMOTES section in
> +	linkgit:git-fetch[1] for details.  This mechanism is legacy
> +	and not likely to be found in modern repositories.
>  
>  hooks::
>  	Hooks are customization scripts used by various git
> @@ -173,9 +167,11 @@ info/exclude::
>  	at it.  See also: linkgit:gitignore[5].
>  
>  remotes::
> -	Stores shorthands to be used to give URL and default
> -	refnames to interact with remote repository to
> -	'git fetch', 'git pull' and 'git push' commands.
> +	Stores shorthands for URL and default refnames for use
> +	when interacting with remote repositories via 'git fetch',
> +	'git pull' and 'git push' commands.  See the REMOTES section
> +	in linkgit:git-fetch[1] for details.  This mechanism is legacy
> +	and not likely to be found in modern repositories.
>  
>  logs::
>  	Records of changes made to refs are stored in this
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
