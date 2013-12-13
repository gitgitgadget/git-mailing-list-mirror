From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/git-credential-gnome-keyring.c: small stylistic cleanups
Date: Fri, 13 Dec 2013 12:07:49 -0800
Message-ID: <xmqqeh5gqzu2.fsf@gitster.dls.corp.google.com>
References: <1386066764-49711-1-git-send-email-john@szakmeister.net>
	<xmqq38m1292g.fsf@gitster.dls.corp.google.com>
	<CAEBDL5Wb+fU=qX4eypt3SrAKQjWRqf9KkNDoutbt7fTsdk02rw@mail.gmail.com>
	<xmqq8uvpskld.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Dec 13 21:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrZ1i-00039w-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 21:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab3LMUHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 15:07:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab3LMUHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 15:07:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A31F158787;
	Fri, 13 Dec 2013 15:07:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JsJFf8BUWKPS3iCdgG/0SuS1e4A=; b=D49k4s
	AxYAWfzfIh/eELW7Afxql9rOG//W/eODS6JcJB8LRl14wmPy4+4ry79+o7Rzrg/S
	7sgmRqdNUicebHjte84PgNMiTDvioEUOubxKoP8M47gwE7Jj1GW0eaaaHyivUZtg
	z9yOc+RO/JnFa1h2TFnF0omqO963FiOpewOLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FSYPuOwIdEx/qkM+TymYeUSYIdBrWIGi
	p7nftGG5hEctBj2GMPGCgKRG7Dr2E7IjaNooN/BblNw32nEFS2rnczHKRhD9lG0b
	lUYR/0qF6N7MJvKeKU8fh6HQbmxlgbypdUsOYd1ToDYj6DvaW2s/eOh4huSN5SxI
	863j3rGoZFE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7982B58786;
	Fri, 13 Dec 2013 15:07:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A5C658785;
	Fri, 13 Dec 2013 15:07:51 -0500 (EST)
In-Reply-To: <xmqq8uvpskld.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 12 Dec 2013 15:41:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3ED2F37A-6432-11E3-A49E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239264>

Junio C Hamano <gitster@pobox.com> writes:

> John Szakmeister <john@szakmeister.net> writes:
>
>> On Mon, Dec 9, 2013 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> [snip]
>>>
>>> I thought we cast without SP after the (typename), i.e.
>>>
>>>         gpointer *data = (gpointer *)user_data;
>>
>> I've found a mixture of both in the code base, and the
>> CodingGuidelines doesn't say either way.  I'm happy to switch the file
>> to no SP after the typename if that's the project preference.
>
> Somewhat arbitrary and unscientific, but between
>
>     git grep -e '[^f]([a-z_ ]* \*)[^ ]' -- \*.c | wc -l
>     422
>     $ git grep -e '[^f]([a-z_ ]* \*) ' -- \*.c | wc -l
>     233
>
> I see that we favor "(struct blah *)apointer" over "(int *)
> apointer".  Many hits in the latter grep come from compat/
> that are borrowed pieces of code we tend not to style-fix.
>
> The leading [^f] is crudely excludes "sizeof(typename *)"; it does
> not change the resulting picture in a major way, though.
>
> Thanks.

Here is a squashable diff on top of your clean-up:

 * A few more violations of the same "asterisk sticks to what is the
   pointer, not the name of the type";

 * No SP between (typename) and castee;

 * Opening parenthesis of "struct/union name" comes on the same line
   as the "struct/union" keyword;

 * Opening parenthesis of structured statements e.g. if/while/for/...
   comes on the same line as the starting keyword;

 * Body of structured controls e.g. if/while/... on a separate line.

I may have caught all of them, but I wasn't trying to be super
careful, so...


diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 1613404..d45503c 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -60,7 +60,7 @@
 #define gnome_keyring_memory_free gnome_keyring_free_password
 #define gnome_keyring_memory_strdup g_strdup
 
-static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
+static const char *gnome_keyring_result_to_message(GnomeKeyringResult result)
 {
 	switch (result) {
 	case GNOME_KEYRING_RESULT_OK:
@@ -95,9 +95,9 @@ static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
 
 static void gnome_keyring_done_cb(GnomeKeyringResult result, gpointer user_data)
 {
-	gpointer *data = (gpointer *) user_data;
-	int *done = (int *) data[0];
-	GnomeKeyringResult *r = (GnomeKeyringResult *) data[1];
+	gpointer *data = (gpointer *)user_data;
+	int *done = (int *)data[0];
+	GnomeKeyringResult *r = (GnomeKeyringResult *)data[1];
 
 	*r = result;
 	*done = 1;
@@ -130,8 +130,7 @@ static GnomeKeyringResult gnome_keyring_item_delete_sync(const char *keyring, gu
 /*
  * This credential struct and API is simplified from git's credential.{h,c}
  */
-struct credential
-{
+struct credential {
 	char *protocol;
 	char *host;
 	unsigned short port;
@@ -144,8 +143,7 @@ struct credential
 
 typedef int (*credential_op_cb)(struct credential *);
 
-struct credential_operation
-{
+struct credential_operation {
 	char *name;
 	credential_op_cb op;
 };
@@ -155,7 +153,7 @@ struct credential_operation
 /* ----------------- GNOME Keyring functions ----------------- */
 
 /* create a special keyring option string, if path is given */
-static char* keyring_object(struct credential *c)
+static char *keyring_object(struct credential *c)
 {
 	if (!c->path)
 		return NULL;
@@ -168,7 +166,7 @@ static char* keyring_object(struct credential *c)
 
 static int keyring_get(struct credential *c)
 {
-	char* object = NULL;
+	char *object = NULL;
 	GList *entries;
 	GnomeKeyringNetworkPasswordData *password_data;
 	GnomeKeyringResult result;
@@ -202,7 +200,7 @@ static int keyring_get(struct credential *c)
 	}
 
 	/* pick the first one from the list */
-	password_data = (GnomeKeyringNetworkPasswordData *) entries->data;
+	password_data = (GnomeKeyringNetworkPasswordData *)entries->data;
 
 	gnome_keyring_memory_free(c->password);
 	c->password = gnome_keyring_memory_strdup(password_data->password);
@@ -302,7 +300,7 @@ static int keyring_erase(struct credential *c)
 	}
 
 	/* pick the first one from the list (delete all matches?) */
-	password_data = (GnomeKeyringNetworkPasswordData *) entries->data;
+	password_data = (GnomeKeyringNetworkPasswordData *)entries->data;
 
 	result = gnome_keyring_item_delete_sync(
 		password_data->keyring, password_data->item_id);
@@ -355,12 +353,11 @@ static int credential_read(struct credential *c)
 
 	key = buf = gnome_keyring_memory_alloc(1024);
 
-	while (fgets(buf, 1024, stdin))
-	{
+	while (fgets(buf, 1024, stdin)) {
 		line_len = strlen(buf);
 
 		if (line_len && buf[line_len-1] == '\n')
-			buf[--line_len]='\0';
+			buf[--line_len] = '\0';
 
 		if (!line_len)
 			break;
@@ -393,7 +390,8 @@ static int credential_read(struct credential *c)
 		} else if (!strcmp(key, "password")) {
 			gnome_keyring_memory_free(c->password);
 			c->password = gnome_keyring_memory_strdup(value);
-			while (*value) *value++ = '\0';
+			while (*value)
+				*value++ = '\0';
 		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
-- 
1.8.5.1-251-gaaad5e7
