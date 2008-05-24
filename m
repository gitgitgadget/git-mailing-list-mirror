From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sat, 24 May 2008 12:43:19 -0500
Message-ID: <5d46db230805241043u7222be34w7dd8cfcb188ef005@mail.gmail.com>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
	 <m34p8o4ijg.fsf@localhost.localdomain>
	 <5d46db230805232216p7936e5dex3aa3ff0e1e0dce06@mail.gmail.com>
	 <m3r6bs2ixn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 19:44:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzxmx-0002pP-TX
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 19:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108AbYEXRnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 13:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757770AbYEXRnX
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 13:43:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:44215 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbYEXRnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 13:43:22 -0400
Received: by wx-out-0506.google.com with SMTP id h29so949027wxd.4
        for <git@vger.kernel.org>; Sat, 24 May 2008 10:43:21 -0700 (PDT)
Received: by 10.70.73.12 with SMTP id v12mr976644wxa.57.1211651000410;
        Sat, 24 May 2008 10:43:20 -0700 (PDT)
Received: by 10.70.60.17 with HTTP; Sat, 24 May 2008 10:43:19 -0700 (PDT)
In-Reply-To: <m3r6bs2ixn.fsf@localhost.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: 297fcd197129fee4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82820>

On Sat, May 24, 2008 at 3:41 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>
> What I forgot to ask: how would you compare Pyrite to similar tool,
> namely to EasyGit?
>

I think the main difference is this, from the first bullet on the eg site
http://www.gnome.org/~newren/eg/

"eg focuses on documentation and examples"

EasyGit is more or less a thin wrapper over git that is fully compatible
(AFAIK).  Elijah can correct me where I am wrong, but I see it as git
training wheels for the command line.  That probably sounds
pejorative but I don't mean it that way.  I am taking the opportunity
to break compatibility in order to see if I can improve usability.  Also, I
don't want to just focus on the command line, I want to affect all areas.

>> On Fri, May 23, 2008 at 8:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>>>
>>>> One of the things that has been commented on by almost any review of
>>>> git are the large numbers of commands that are present and the
>>>> endless stream of flags, options, configuration variables and
>>>> syntaxes that are present in git.  They certainly serve a purpose
>>>> and I probably would not be able to do this without all those things
>>>> but it can get in a normal users way some times.  Here are some of
>>>> the steps I have and will be taking.
>>>
>>> Which is bogus, because most of those commands are plumbing, [almost]
>>> never to be used by user directly.
>>>
>>> If I understand correctly in next major git release those commands are
>>> to be hidden and not present in PATH anymore.
>>
>> That may be true but it is only part of the story.  I see plumbing commands
>> being given to users all the time on the mailing list.  Usually in some
>> combination.  To make it worse they usually get several sets of commands
>> that do something similar but any one may or may not be exactly what
>> they want because not everyone who responds fully understands what the
>> commands are doing.
>
> The change to "git help" to show only porcelain commands unless
> explicitely requested, and to git(7) manpage to have porcelain first
> would help there.
>
> But I think using plumbing in examples are remainder of git early
> days, where it was the only way to work with git.  Tools like Pyrite,
> or EasyGit, wouldn't change it...
>

The idea is that there should be one fairly obvious way to do something.
If you have that then there is less confusion, especially when someone
asks for help.  Plus, if there is one fairly obvious way to do something,
then people will need to ask for help less often.  That is what I hope to
accomplish.

>>>> 1) Reduce the number of commands.
> [...]
> I think you should start not with "minimal number of commands" as a
> goal, but rather with set of distinct tasks ordinary (not scripting)
> user might need, and how to map them into commands.
>
> To heavily overloaded commands are as much if not worse than having
> too many commands to choose from.
>

This is true.  This idea is fairly new and I am still deciding exactly
how things
would get broken up.  After thinking about it, "checkout" probably should
not be combined with the fetch/pull/merge command because they are
too different.  Here is how I am thinking of combining things, perhaps you
and others can give some pointers on what is crazy and what might work.

The ones prefixed with * are the ones that would show up in the short
help, the ones that would be the most typically used.

  bisect = bisect
  blame = blame
* commit = commit + push + stash + init
          push:  This is here because it fits the traditional notion of what a
                    commit does, which is to send a commit to the central
                    server.  I think of it as "I am committing my changes to
                    the remote repository.
          stash:  What is stash but a temporary commit (not on the branch)?
          init: This can be done a couple of ways, either your initial
                  commit is combined with the init or --init is a flag
                  passed to commit to set up the NULL commit.  At least
                  thats how I think of it conceptually.
* checkout = checkout + clone + branch + remote
* config = config
  cherry = cherry + cherry-pick
* diff = diff
  gc = clean + gc + prune + repack
         I plan to make full use of gc --auto to avoid having the
         user run this command, but everyone knows there
         are reasons to run these commands even with --auto.
         "Clean" seems to me to be the working directory version
         of gc.
* gui = gui
* help = help
  import = apply + cvsimport + <scm>import + am
         Here the import strategies would be provided by addons
         and such with apply/am as standard.
  mail = format-patch + send-mail
  move = move
* pull = pull, fetch, merge
  rebase = rebase
  remove = remove
* resolve = mergetool
  revert = reset + reflog
          I was thinking of calling this command "recover" instead of
          revert, which I still think might describe what I want to do
          and might tell you why I think that reflog is something to
          combine here.  "revert --what-can-i-revert-to" would show
          the output of reflog.  That wouldn't be the actual name
          of the flag, but it gives you the idea.
* serve
* show = show + ls + log + grep + rev-list + rev-parse + describe
          Combining all this may raise a few eye-brows, but I think
          it makes sense.  Really this command is git log + ls-files +
          describe and the ability of showing files from other revisions
          from git show, the rest can be reduced to functionality already
          available in git log.
* status = status
  submodule
  tag
* track = add/addremove
  verify = fsck

>> >> 2) Reduce complexity.
> [...]
>>>> 3) Addons.
[snip problems with revision numbers]
> [...]
>> I responded to this in another mail.  The other DVCSs don't claim that
>> revision numbers are all of those things.  It is only necessary that when
>> two people say the same thing, it mean the same thing.
>
>> This doesn't stop them from using these numbers more than the sha1
>> IDs because given a branch, the numbers are solid.  Doing things the
>> way I propose has the same properties.
>
> I wonder how useful in practice those revision numbers are in larger
> repositories, with nonlinear history, i.e. if -r 6453:master -R 6455:master
> (or something like that) is truly easier to use than master~2..master
>
> I _think_ that sha-1 are largely theoretical scare, as for example I
> don't use them much, and if I use them it is in copy'n'paste manner.
>

They are useful for a different purpose.  If I say master~5 today it
probably won't yield the same commit tomorrow.  while 6450:master would.
Honestly, I have absolutely no problem with using sha1s myself, I just put
this in because I have seen several people ask for it on the mailing list
recently.  I thought to myself, that they COULD have it if they really wanted.
Also keep in mind that 12345: is usually enough as an empty RHS would
default to HEAD, which saves a bit of typing.

>>>> 5) One stop shop.
[snip windows + webserver headaches]
>>> BTW. there always is git-instaweb.
>>>
>>
>> Yeah, but I still need the webserver, thats what I want to get rid of.  If you
>> want to do some ad-hoc sharing it is a huge problem and you may not
>> have permissions/time to install software.
>>
>>> But having git-serve would be nice...
>>>
>>
>> Indeed.
>
> And with Python AFAIK you can quite easily set up _simple_ web server
> for HTTP access and browsing repository...
>
> BTW. there was at some time git web interface in Python (old wit), but
> it lost to gitweb; nowadays Ruby, eRuby or Ruby on Rails seems to be
> the rage (new Wit (from XMMS2), Gitarella, Gitorious, GitHub).
>
I was thinking of using Django so that I could reuse the stuff that the
review-board folks are doing.  I like their side-by-side diffs etc.  But here
is the kicker, I want to use this to do what the hg people have done.
They built their remote push-pull functionality into their built-in webserver.
If we do this then the pyrite http protocol can be a smart transport.  I
believe that bzr has a similar feature in theirs.

Thanks for taking a look and giving me your opinion, I like getting
feedback about this.

-Govind
