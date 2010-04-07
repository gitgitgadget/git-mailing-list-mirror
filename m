From: Tay Ray Chuan <rctay89@gmail.com>
Subject: (resend) Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Thu, 8 Apr 2010 02:27:56 +0800
Message-ID: <u2ube6fef0d1004071127r6f64fcb1scfc7d23c59db2b20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 20:28:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzZyx-0000K1-KW
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514Ab0DGS16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 14:27:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35574 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab0DGS15 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 14:27:57 -0400
Received: by pwj9 with SMTP id 9so1248003pwj.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=kmykdw2k0pPo1o2OhYk9FBw7+Yq4W1K6l4yOYcteciQ=;
        b=ICjFrLbjpvzUKdic9i7bJ4OfwjMrvIRrNAJkHIntvRf8WynM4pFY6jn8q+gjoHvw1n
         CtP8XQs6n4Y6pZ+jVolFsQJIqzXFLOrWL0Hvk0zafirW2JWlWq4eWZfjzRSnL3141DBv
         D/MwXhsD4AiAJaPDnVGxFeb+5waFZgWzDj9yA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=mWJZbgJSwH/O9qtn+tsBHXg/Gac2f+AdoP5KMfmzqxLKpWP5xzNIDy2tLT7uctpbKm
         JoyLv3JVinbID+Nk1QDGdBysPSMY5xcDyucVt9H8ZS7da6kkpbyXMwsHxUE9sImuKI77
         Caf5vJHVFXhq5WaOaqpxojo65MRaaw7KwirZY=
Received: by 10.231.10.65 with HTTP; Wed, 7 Apr 2010 11:27:56 -0700 (PDT)
Received: by 10.114.214.33 with SMTP id m33mr9041772wag.107.1270664876208; 
	Wed, 07 Apr 2010 11:27:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144261>

(sorry for the multiple copies - something wrong with my MUA. Had to
give it a kiss in the a** to get it working.)

Hi,

(I'm reviving this thread to complete the document. What I have right
now is available at my github repo; you can see it at

=A0http://github.com/rctay/git/compare/git/next...feature/http-doc#file=
s_bucket

=2E

An inlined patch should be sent in soon.)

On Fri, 09 Oct 2009 13:44:53 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > diff --git a/Documentation/technical/http-protocol.txt b/Documentat=
ion/technical/http-protocol.txt
> > new file mode 100644
> > index 0000000..316d9b6
> > --- /dev/null
> > +++ b/Documentation/technical/http-protocol.txt
> > @@ -0,0 +1,542 @@
> > +HTTP transfer protocols
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > ...
> > +As a design feature smart clients can automatically upgrade "dumb"
> > +protocol URLs to smart URLs. =A0This permits all users to have the
> > +same published URL, and the peers automatically select the most
> > +efficient transport available to them.
>
> The first sentence feels backwards although the conclusion in the sec=
ond
> sentence is true. =A0It is more like smart ones trying smart protocol=
 first,
> and downgrading to "dumb" after noticing that the server is not smart=
=2E

I think Shawn is trying to describe this from the persepective of the
client implementation - a "dumb" url is first constructed, then
"upgraded" to a "smart" one.

> > +Authentication
> > +--------------
> > ...
> > +Clients SHOULD support Basic authentication as described by RFC 26=
16.
> > +Servers SHOULD support Basic authentication by relying upon the
> > +HTTP server placed in front of the Git server software.
>
> It is perfectly fine to make it a requirement for a server to support=
 the
> Basic authentication, but should you make it a requirement that the
> support is done by a specific implementation, i.e. "by relying upon..=
=2E"?

I think the term "Server" in this document is implied as an amalgam of
the HTTP server, and a CGI script/program ("Git server software"). I
think what Shawn meant was for Basic authentication to be implemented
at the server layer, not in the CGI scripts/program.

> > +Session State
> > +-------------
> > ...
> > +retained and managed by the client process. =A0This permits simple
> > +round-robin load-balancing on the server side, without needing to
> > +worry about state mangement.
>
> s/mangement/management/;

Done.

> > +pkt-line Format
> > +---------------
> > ...
> > +Examples (as C-style strings):
> > +
> > + =A0pkt-line =A0 =A0 =A0 =A0 =A0actual value
> > + =A0---------------------------------
> > + =A0"0006a\n" =A0 =A0 =A0 =A0 "a\n"
> > + =A0"0005a" =A0 =A0 =A0 =A0 =A0 "a"
> > + =A0"000bfoobar\n" =A0 =A0"foobar\n"
> > + =A0"0004" =A0 =A0 =A0 =A0 =A0 =A0""
> > +
> > +A pkt-line with a length of 0 ("0000") is a special case and MUST
> > +be treated as a message break or terminator in the payload.
>
> Isn't this "MUST be" wrong?
>
> It is not an advice to the implementors, but the protocol specificati=
on
> itself defines what the flush packet means. =A0IOW, "The author of th=
is
> specification, Shawn, MUST treat a flush packet as a message break or
> terminator in the payload, when designing this protocol."

This section has been purged; we already have this in
Documentation/technical/protocol-common.txt.

> > +General Request Processing
> > +--------------------------
> > +
> > +Except where noted, all standard HTTP behavior SHOULD be assumed
> > +by both client and server. =A0This includes (but is not necessaril=
y
> > +limited to):
> > +
> > +If there is no repository at $GIT_URL, the server MUST respond wit=
h
> > +the '404 Not Found' HTTP status code.
>
> We may also want to add
>
> =A0 =A0 If there is no object at $GIT_URL/some/path, the server MUST =
respond
> =A0 =A0 with the '404 Not Found' HTTP status code.
>
> to help dumb clients.

Proposed re-wording:

=A0If there is no repository at $GIT_URL, or the resource pointed to by=
 a
=A0location containing $GIT_URL does not exist, the server MUST NOT res=
pond
=A0with '200 OK' response. =A0A server SHOULD respond with
=A0'404 Not Found', '410 Gone', or any other suitable HTTP status code
=A0which does not imply the resource exists as requested.

(The 'valid info/refs response' part has been dropped.)

> > +Dumb Clients
> > +~~~~~~~~~~~~
> > +
> > +HTTP clients that only support the "dumb" protocol MUST discover
> > +references by making a request for the special info/refs file of
> > +the repository.
> > +
> > +Dumb HTTP clients MUST NOT include search/query parameters when
> > +fetching the info/refs file. =A0(That is, '?' must not appear in t=
he
> > +requested URL.)
>
> It is unclear if '?' can be part of $GIT_URL. E.g.
>
> =A0 =A0 $ wget http://example.xz/serve.cgi?path=3Dgit.git/info/refs
> =A0 =A0 $ git clone http://example.xz/serve.cgi?path=3Dgit.git
>
> It might be clearer to just say
>
> =A0 =A0 Dumb HTTP clients MUST make a GET request against $GIT_URL/in=
fo/refs,
> =A0 =A0 without any search/query parameters. =A0I.e.
>
> =A0 =A0 =A0 C: GET $GIT_URL/info/refs HTTP/1.0
>
> to also exclude methods other than GET.

Done.

> > + =A0 C: GET $GIT_URL/info/refs HTTP/1.0
> > +
> > + =A0 S: 200 OK
> > ...
> > +When examining the response clients SHOULD only examine the HTTP
> > +status code. =A0Valid responses are '200 OK', or '304 Not Modified=
'.
>
> Isn't 401 ("Ah, I was given a wrong URL") and 403 ("Ok, I do not have=
 an
> access to this repository") also valid?

I think "valid" for the client means "ok, continue processing
normally".

> > +The returned content is a UNIX formatted text file describing
> > +each ref and its known value. =A0The file SHOULD be sorted by name
> > +according to the C locale ordering. =A0The file SHOULD NOT include
> > +the default ref named 'HEAD'.
>
> I know you said "known" to imply "concurrent operations may change it
> while the server is serving this client", but it feels rather awkward=
=2E

TODO

> > +Smart Server Response
> > +^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Smart servers MUST respond with the smart server reply format.
> > +If the server does not recognize the requested service name, or th=
e
> > +requested service name has been disabled by the server administrat=
or,
> > +the server MUST respond with the '403 Forbidden' HTTP status code.
>
> This is a bit confusing.
>
> If you as a server administrator want to disable the smart upload-pac=
k for
> one repository (but not for other repositories), you would not be abl=
e to
> force smart clients to fall back to the dumb protocol by giving "403"=
 for
> that repository.
>
> Maybe in 2 years somebody smarter than us will have invented a more
> efficient git-upload-pack-2 service, which is the only fetch protocol=
 his
> server supports other than dumb. =A0If your v1 smart client asks for =
the
> original git-upload-pack service and gets a "403", you won't be able =
to
> fall back to "dumb".
>
> The solution for such cases likely is to pretend as if you are a dumb
> server for the smart request. =A0That unfortunately means that the fi=
rst
> sentence is misleading, and the second sentence is also an inappropri=
ate
> advice.

Proposed rewording:

=A0If the server does not recognize the requested service name, or the
=A0requested service name has been disabled by the server administrator=
,
=A0the server MUST respond with the '403 Forbidden' HTTP status code.

=A0Otherwise, smart servers MUST respond with the smart server reply
=A0format for the requested service name.

> > +The Content-Type MUST be 'application/x-$servicename-advertisement=
'.
> > +Clients SHOULD fall back to the dumb protocol if another content
> > +type is returned. =A0When falling back to the dumb protocol client=
s
> > +SHOULD NOT make an additional request to $GIT_URL/info/refs, but
> > +instead SHOULD use the response already in hand. =A0Clients MUST N=
OT
> > +continue if they do not support the dumb protocol.
>
> The part I commented on (the beginning of Smart Server Response) was
> written as a generic description, not specific to git-upload-pack ser=
vice,
> and the beginning of this paragraph also pretends to be a generic
> description, but it is misleading. =A0This is a specific instruction =
to the
> clients that asked for git-upload-pack service and got a dumb server
> response (if the above were talking about something other than upload=
-pack
> service, there is no guarantee that "response already in hand" is use=
ful
> to talk to dumb servers).

Previous hunk should fix this.

> > + =A0 ref_list =A0 =A0 =A0 =3D empty_list | populated_list
> > +
> > + =A0 empty_list =A0 =A0 =3D PKT-LINE(id SP "capabilities^{}" NUL c=
ap_list LF)
> > +
> > + =A0 non_empty_list =3D PKT-LINE(id SP name NUL cap_list LF)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ref_record
>
> [snip]
>
> Did you define what "populated_list" is?

I think "non_empty_list" was meant.

Ideally, ref advertisements should be in protocol-common.txt.

> > +Smart Service git-upload-pack
> > +------------------------------
> > +This service reads from the remote repository.
>
> The wording "remote repository" felt confusing. =A0I know it is "from=
 the
> repository served by the server", but if it were named without
> "upload-pack", I might have mistaken that you are allowing to proxy a
> request to access a third-party repository by this server. =A0The sam=
e
> comment applies to the git-receive-pack service.

Would

=A0This service reads from the repository pointed to by $GIT_URL.

be an improvement?

> > +Capability include-tag
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +When packing an object that an annotated tag points at, include th=
e
> > +tag object too. =A0Clients can request this if they want to fetch
> > +tags, but don't know which tags they will need until after they
> > +receive the branch data. =A0By enabling include-tag an entire call
> > +to upload-pack can be avoided.
> > +
>
> I think you are avoiding an "extra" call; you would need one entire c=
all
> to upload-pack anyway for the primary transfer.

Done.

--
Cheers,
Ray Chuan
