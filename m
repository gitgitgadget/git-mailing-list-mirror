From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: P4 Sync problem
Date: Wed, 11 Nov 2009 14:54:23 +0100
Message-ID: <1a6be5fa0911110554u7c3a04c8hf50100b784b63c7a@mail.gmail.com>
References: <loom.20091110T145046-137@post.gmane.org>
	 <1a6be5fa0911110043i63b5c032s7924f9f1cdfe32ee@mail.gmail.com>
	 <loom.20091111T100646-406@post.gmane.org>
	 <1a6be5fa0911110400l1fe931afmbb53ceba8704e029@mail.gmail.com>
	 <loom.20091111T131837-901@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 14:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8DeZ-0005mX-7X
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 14:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbZKKNyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 08:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbZKKNyT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 08:54:19 -0500
Received: from gv-out-0910.google.com ([216.239.58.190]:25893 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbZKKNyT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 08:54:19 -0500
Received: by gv-out-0910.google.com with SMTP id r4so54640gve.37
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 05:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QCYi7ETIBJ4aT+bqEj0WXb+c5T3HTYTzMUe6qCatdL4=;
        b=xZWLCiq3dTWurTHBlVA/rLBf0UHQthyRWAsK04oPReoHG9gBmayzGf7q1fFljqduZD
         4q7bpqwEaWTFKzbbNigPBnFgtYgnlX2+4/ljQiijjm308ZDh1ueQ5CrfacwzkByFhvQF
         XR34ctPOngBna/EGbHXfVSL1RpFsysA1pM2N8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BIPrFMIcTQs11clTM0gEIphVi4GN6JKvp+UTDGOC+quTw+KxbUqPfjzVblZYmu2C2L
         BXlzccD6zA17aQq+hzzjv6/b+7BFubRP3O/8hOyoEkAXQmCx74pwU5cc8Qg9rjMJC2KL
         7eyolKe9+XuONsJLM5UkhLc6zwAiGWObYnqvE=
Received: by 10.239.163.222 with SMTP id q30mr138079hbd.128.1257947663180; 
	Wed, 11 Nov 2009 05:54:23 -0800 (PST)
In-Reply-To: <loom.20091111T131837-901@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132654>

On Wed, Nov 11, 2009 at 1:39 PM, Dmitry Smirnov <divis1969@gmail.com> w=
rote:
> Tor Arvid Lund <torarvid <at> gmail.com> writes:
>
>
>> Well, I see what you're trying to do, but I would not want to see th=
at
>> patch in the official script, because some (most?) people (myself, a=
t
>> least) use git-p4 to clone single projects out of a perforce depot
>> that may contain many projects. I do this myself by doing:
>>
>> git p4 clone //depot/path/to/projectX <at> all
>>
>> I usually use one clientspec in perforce, and I do not want to chang=
e
>> that... With your patch, I would be in trouble since my clientspec
>> contains "//depot/..." (followed by a lot of lines starting with '-'=
)
>
> Well, does this mean that if you try to sync the client in perforce (=
visual or
> command line), you will sync all the projects?

Yes, but I generally try to not use perforce, but git instead :-)

> In that case, git p4 will require significant effort to satisfy both =
of us :-)
> Unfortunatly, it seems I'm in minory group of git-p4 users...

I don't know, but if I were to guess, then yes, you probably are... If
you have a complex perforce client spec setup, then there may of
course be problems that git-p4 might not solve for you. Since nobody
has volunteered to implement the features you describe yet, I believe
that most of us git-p4 users have fairly simple client spec setups.

=46or me, most projects in p4 are such that I can give one root
directory to "git p4 sync", and it works for me. I of course have
several git projects that sync from the same p4 server (only with
different root dirs). In cases where you have dependencies between
such projects, you should maybe read about git submodules - or maybe
googles "repo" script (search for "google repo git"). I don't know
much about any of these, other than 'they exist, and seemingly try to
solve such issues' :-/

> i would propose to use both command-line arguments and a client spec
> to create a correct filter of what should be synced/cloned.
> BTW, it looks this script does not honor neither the order of paths
> in the spec (which can be important) nor mapping of the files to a lo=
cal tree.

When you have a client spec like:

//depot/A/...
-//depot/A/B/...
//depot/A/B/C/...

=2E.. git-p4 sorts these paths by length. For a given filename, it find=
s
the longest path that matches that files directory, and if that path
starts with a '-', the file is not synced (for a file
"//depot/A/B/myfile.c" it gets a match on "-//depot/A/B/...", and
myfile.c is not synced, but the file "//depot/A/B/C/myotherfile.c" it
matches "//depot/A/B/C/...")

Do you have an example that shows how it might fail?

And no, git-p4 does not care about the local mappings, it reads only
the server part.

-Tor Arvid-

>> If you want to fix it, you might want to rename clientSpecDirs to
>> clientSpecEntries or something like that.
>
> For now, I just commented out two lines in the run() procedure:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#if not p.endswith("/"):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0p +=3D "/"
>
>> Btw... Am I understanding correctly what it is you wish to accomplis=
h?
>> I'm guessing that you have a perforce server with a client spec set
>> up, and you want to sync everything on the entire server according t=
o
>> that client spec?
>
> yes. Client spec completely defines the project layout for me.
> It contains paths to some components that are mapped to the
> client working tree.
> Just if your CS contain
>
> //depot/path/to/projectX/... //CLIENT/...
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
