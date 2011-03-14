From: "Franz Liedke" <franz@develophp.org>
Subject: Re: [Support] Branch pointer does not move
Date: Mon, 14 Mar 2011 17:44:00 +0100
Organization: develoPHP
Message-ID: <op.vscd3mnbbl4hj1@metalltrottel.fritz.box>
References: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box>
 <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com>
 <op.vsb95dilbl4hj1@metalltrottel.fritz.box>
 <AANLkTimW+01wriSjvEVEyQ8SE5RPxhGv_o2Rus9kw6ZQ@mail.gmail.com>
 <op.vscae5mbbl4hj1@metalltrottel.fritz.box>
 <4D7E38C6.4010804@drmicha.warpmail.net>
 <op.vsccqtbobl4hj1@metalltrottel.fritz.box>
 <4D7E4277.8040202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Sverre Rabbelier" <srabbelier@gmail.com>, git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 14 17:44:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzAsY-0001IQ-JC
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 17:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692Ab1CNQoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 12:44:16 -0400
Received: from relay01.alfahosting-server.de ([80.86.191.88]:57294 "EHLO
	relay01.alfahosting-server.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754238Ab1CNQoO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 12:44:14 -0400
Received: by relay01.alfahosting-server.de (Postfix, from userid 1001)
	id E6A2932C04BD; Mon, 14 Mar 2011 17:44:11 +0100 (CET)
X-Spam-DCC: SION: relay01 1111; Body=1 Fuz1=1 Fuz2=1
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=7.0 tests=BAYES_50 autolearn=disabled
	version=3.2.5
Received: from alfa3007.alfahosting-server.de (alfa3007.alfahosting-server.de [82.197.146.14])
	by relay01.alfahosting-server.de (Postfix) with ESMTP id CDE1432C0733;
	Mon, 14 Mar 2011 17:42:18 +0100 (CET)
Received: from metalltrottel.fritz.box (sd-89-66.stud.uni-potsdam.de [141.89.89.66])
	by alfa3007.alfahosting-server.de (Postfix) with ESMTPSA id A29512F04CD6;
	Mon, 14 Mar 2011 17:42:18 +0100 (CET)
In-Reply-To: <4D7E4277.8040202@drmicha.warpmail.net>
User-Agent: Opera Mail/11.01 (Win32)
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with ClamAV 0.97/12836/Mon Mar 14 16:11:19 2011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168999>

On Mon, 14 Mar 2011 17:29:43 +0100, Michael J Gruber  
<git@drmicha.warpmail.net> wrote:

> I don't know how smartgit reacts when you switch the branch in git while
> smartgit is running, for example.
>
That works just fine. SmartGit does really well when it comes to  
refreshing.

>> I ran some sort of cleanup tool yesterday, possibly about the time when
>> the problem started (I only noticed it today). Something along the lines
>> of 'git gc' maybe, if I remember correctly. Could that be the cause?
>
> git gc does not do any evil as long as you're not accessing the repo
> with another client at the same time.
Ah, there we go. I was.

> So, have you lost any commits? Maybe something like
>
> git log --graph --abbrev-commit --pretty=oneline --decorate --all
>
> will give you a clearer picture of where your commits went. If they're
> not there then inspecting the reflog of HEAD may help:
>
> git log -g --abbrev-commit --pretty=oneline --decorate HEAD
No, I did not lose anything. Commits were added to the log correctly, but  
the branch pointer stayed where it was.

I've appended the output of the second command below. Is it correct that  
the branch name appears in front of every commit in that branch  
("168-...", down to the one where the problem started, actually; that's  
where it stops displaying the name)?

---

d07b4b6 (HEAD, lie2815/fluxbb-1.4, fluxbb-1.4) HEAD@{0}: commit: #168: Fix  
query bug and don't display buttons when we don't show any results?
57d8f07 HEAD@{1}: checkout: moving from 168-users-mass-edit to fluxbb-1.4
e5b0b91 (168-users-mass-edit) HEAD@{2}: HEAD^ --: updating HEAD
099c040 HEAD@{3}: commit: Test
e5b0b91 (168-users-mass-edit) HEAD@{4}: checkout: moving from fluxbb-1.4  
to 168-users-mass-edit
57d8f07 HEAD@{5}: commit (amend): #168: Merge commits that were ignored in  
previous commits. Mainly related to moving users to different groups.
f27510a HEAD@{6}: commit: #168: Merge commits that were ignored in  
previous merge.
e1dcbf6 HEAD@{7}: checkout: moving from master to fluxbb-1.4
be38cd6 (master) HEAD@{8}: checkout: moving from 168-users-mass-edit to  
master
e5b0b91 (168-users-mass-edit) HEAD@{9}: HEAD^ --: updating HEAD
327259b HEAD@{10}: commit: test
e5b0b91 (168-users-mass-edit) HEAD@{11}: HEAD^ --: updating HEAD
7137c68 HEAD@{12}: commit: test
e5b0b91 (168-users-mass-edit) HEAD@{13}: HEAD^ --: updating HEAD
70169b6 HEAD@{14}: commit: Foobar test commit.
e5b0b91 (168-users-mass-edit) HEAD@{15}: checkout: moving from fluxbb-1.4  
to 168-users-mass-edit
e1dcbf6 HEAD@{16}: commit: #168: Add batch actions for banning, deleting  
and moving users to the admin users page.
1587022 (origin/fluxbb-1.4) HEAD@{17}: merge origin/fluxbb-1.4:  
Fast-forward
7c4b93b HEAD@{18}: checkout: moving from 168-users-mass-edit to fluxbb-1.4
e5b0b91 (168-users-mass-edit) HEAD@{19}: commit: Change form markup. #168
15186ad HEAD@{20}: commit: #168: Implement moving users to another group.
02a4541 HEAD@{21}: commit: Don't allow moderators to mass ban other  
moderators. #168. Related to #343.
ccb44c8 HEAD@{22}: checkout: moving from fluxbb-1.4 to 168-users-mass-edit
7c4b93b HEAD@{23}: rebase: #343: Moderators could ban other moderators.
e313ed0 HEAD@{24}: checkout: moving from fluxbb-1.4 to  
e313ed0a936071a6abe7efcabcd79f6de295822e^0
5980b56 HEAD@{25}: commit: #343: Moderators could ban other moderators.
d9824a9 HEAD@{26}: checkout: moving from 168-users-mass-edit to fluxbb-1.4
ccb44c8 HEAD@{27}: commit (amend): Add button for changing user group. #168
ccbdebd HEAD@{28}: commit: Add button for changing user group. #168
731a790 HEAD@{29}: commit: Display admin menu on user deletion  
confirmation page, too. #168
a494a13 HEAD@{30}: HEAD^ --: updating HEAD
ac9bdf9 HEAD@{31}: commit: Display admin menu on user deletion  
confirmation page, too. #168
a494a13 HEAD@{32}: HEAD^ --: updating HEAD
d73a7b3 HEAD@{33}: commit: Display admin menu on user deletion  
confirmation page, too. #168
a494a13 HEAD@{34}: HEAD^ --: updating HEAD
c99c40c HEAD@{35}: commit: foobarba
a494a13 HEAD@{36}: HEAD^ --: updating HEAD
6345b66 HEAD@{37}: commit: foobarba
a494a13 HEAD@{38}: commit (amend): Implement banning of multiple users.  
#168
7bea1d7 HEAD@{39}: commit: Implement banning of multiple users. #168
d4cd3f9 HEAD@{40}: HEAD^ --: updating HEAD
9de9d8f HEAD@{41}: commit: Implement banning of multiple users. #168
d4cd3f9 HEAD@{42}: HEAD^ --: updating HEAD
54eb388 HEAD@{43}: commit (amend): Implement banning of multiple users.  
#168
29f8471 HEAD@{44}: commit: Implement banning of multiple users. #168
d4cd3f9 HEAD@{45}: commit: Only show checkboxes and action buttons on  
admin users list when permissions are sufficient. #168.
7560b75 HEAD@{46}: commit: More logical check for valid user IDs when  
deleting users. #168.
9f73b8d HEAD@{47}: commit: Switch order of action buttons and "select all"  
link in admin users page. #168
891c4fe HEAD@{48}: checkout: moving from fluxbb-1.4 to 168-users-mass-edit
d9824a9 HEAD@{49}: checkout: moving from fluxbb-1.2 to fluxbb-1.4
f233870 (origin/fluxbb-1.2, lie2815/fluxbb-1.2, fluxbb-1.2) HEAD@{50}:  
commit: #240: Fix authentication cookie being set incorrectly in some  
cases.
0a71ae9 (tag: fluxbb-1.2.23) HEAD@{51}: checkout: moving from  
168-users-mass-edit to fluxbb-1.2
891c4fe HEAD@{52}: commit: Move JavaScript code to a file common.js and  
only use one link for toggling checkboxes.
e9349be HEAD@{53}: checkout: moving from fluxbb-1.4 to 168-users-mass-edit
d9824a9 HEAD@{54}: HEAD^ --: updating HEAD
f39af9d HEAD@{55}: commit: #294: Limit size of tracking cookie so that  
there is some more space in nginx.
d9824a9 HEAD@{56}: commit: #330: Fix my feed fix. XML-namespace-related.
2b470b6 HEAD@{57}: commit: #331: Fix hard-coded language entry on admin  
reports page.
e0fa124 HEAD@{58}: commit: Enhance RSS feeds by adding atom:link with  
rel="self".
5abbbfc HEAD@{59}: checkout: moving from master to fluxbb-1.4
be38cd6 (master) HEAD@{60}: checkout: moving from fluxbb-2.0 to master
20b0441 (origin/fluxbb-2.0, lie2815/fluxbb-2.0, fluxbb-2.0) HEAD@{61}:  
checkout: moving from 168-users-mass-edit to fluxbb-2.0
e9349be HEAD@{62}: commit: Implement mass deletion of users. #168.
1dff30b HEAD@{63}: checkout: moving from master to 168-users-mass-edit
be38cd6 (master) HEAD@{64}: merge origin/master: Fast-forward
f813ef5 HEAD@{65}: checkout: moving from 168-users-mass-edit to master
1dff30b HEAD@{66}: commit: Add JavaScript code for selecting / unselecting  
multiple checkboxes.
4acd8f8 HEAD@{67}: checkout: moving from master to 168-users-mass-edit
f813ef5 HEAD@{68}: pull origin master: Fast-forward
d55266d HEAD@{69}: checkout: moving from 168-users-mass-edit to master
4acd8f8 HEAD@{70}: checkout: moving from master to 168-users-mass-edit
d55266d HEAD@{71}: commit: #272: Add new language string to install.php  
for default name of Guests group
4291ae6 HEAD@{72}: pull origin master: Fast-forward
28d33cf HEAD@{73}: commit: Change breadcrumbs text in search results  
depending on whether we're searching for posts or topics.
1bef6cc HEAD@{74}: commit: #274: Fix usernames in breadcrumbs being  
converted to lower-case when searching for posts by author name.
971f14e HEAD@{75}: commit: #257: Apply my last commit to edit.php, too.
---

Thanks for your help again
Franz
