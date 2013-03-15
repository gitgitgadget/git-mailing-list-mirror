From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Fri, 15 Mar 2013 18:41:29 +0100
Message-ID: <51435D49.6040005@web.de>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com> <1363179556-4144-1-git-send-email-pclouds@gmail.com> <7vehfj46mu.fsf@alter.siamese.dyndns.org> <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com> <7vmwu6yqbd.fsf@alter.siamese.dyndns.org> <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com> <514343BA.3030405@web.de> <7vvc8svc2r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	artagnon@gmail.com, robert.allan.zeh@gmail.com, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 18:42:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGYdu-0002MS-R0
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 18:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab3CORlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 13:41:44 -0400
Received: from mout.web.de ([212.227.17.12]:54441 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754491Ab3CORln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 13:41:43 -0400
Received: from [192.168.209.16] ([195.67.191.23]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MUWCB-1U6tqo13Dv-00QuMx; Fri, 15 Mar 2013 18:41:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <7vvc8svc2r.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:UgzEz+gwQA8Tc0m0KVNyGhZ6RrWggn18JBgS5bNpdId
 M8ZPXBfFaN4uvqtQ6/xe2MMmJrjbS39dJbsMsj76tfjXPUv9Yp
 BRHa29VlFbQyFyH9yD0qBQqA/YGUcXghvJELzKLlOOzEIhQtnO
 xF5t2IYHLQvISXtefrCE4oRbYSdEgkYSbdDXiHiWoRCvhMGNdN
 +CNxMms4KvnJDaeqZdW5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218255>

On 03/15/2013 05:53 PM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen<tboegi@web.de>  writes:
>
>> [PATCH] git status: Document that git status -uno is faster
>>
>> In some repostories users expere that "git status" command takes lon=
g time.
> expere???  Certainly you did not mean "expect".  "observe",
> "experience", or "see", perhaps?
>
>> The command spends some time searching the file system for untracked=
 files.
>> Document that searching for untracked file may take some time, and d=
ocuemnt
>> the option -uno better.
> Good intentions.
>
>> Signed-off-by: Torsten B=C3=B6gershausen<tboegi@web.de>
>> ---
>>   Documentation/git-status.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/git-status.txt b/Documentation/git-status=
=2Etxt
>> index 0412c40..fd36bbd 100644
>> --- a/Documentation/git-status.txt
>> +++ b/Documentation/git-status.txt
>> @@ -58,6 +58,13 @@ The possible options are:
>>   The default can be changed using the status.showUntrackedFiles
>>   configuration variable documented in linkgit:git-config[1].
>>
>> ++
>> +Note: Searching the file system for untracked files may take some t=
ime.
>> +git status -uno is faster than git status -uall.
>> +There is a trade-off around the use of -uno between safety and perf=
ormance.
>> +The default is not to use -uno so that you will not forget to add a
>> file you newly created (i.e safety).
>> +You would pay for the safety with the cost to find such untracked
>> files (i.e. performance).
>> +
> The second sentence looks out of flow, and the last sentence, while
> technically not incorrect, is unclear what it is trying to convey in
> the larger picture.
>
> Perhaps it is just me.
>
> In any case, I think it is a good idea to explain the reason why the
> user might want to use a non-default setting, and the criteria the
> user may want to base the choice on (which is the gist of your
> addition), and it is a good idea to do so _before_ saying "The
> default can be changed using ...".
>
> How about this?
>
>   Documentation/git-status.txt | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.=
txt
> index 0412c40..9046df9 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -46,15 +46,21 @@ OPTIONS
>   	Show untracked files.
>   +
>   The mode parameter is optional (defaults to 'all'), and is used to
> -specify the handling of untracked files; when -u is not used, the
> -default is 'normal', i.e. show untracked files and directories.
> +specify the handling of untracked files.
>   +
>   The possible options are:
>   +
> -	- 'no'     - Show no untracked files
> -	- 'normal' - Shows untracked files and directories
> +	- 'no'     - Show no untracked files.
> +	- 'normal' - Shows untracked files and directories.
>   	- 'all'    - Also shows individual files in untracked directories.
>   +
> +When `-u` option is not used, untracked files and directories are
> +shown (i.e. the same as specifying `normal`), to help you avoid
> +forgetting to add newly created files.  Because it takes extra work
> +to find untracked files in the filesystem, this mode may take some
> +time in a large working tree.  You can use `no` to have `git status`
(Small nit: extra space before the "You" in the line above)

Thanks, I like that much better than mine
(and expere is probably a word not yet invented)
/Torsten
